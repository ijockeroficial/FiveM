#!/bin/bash

# Script automático para configurar proxy/cache FiveM com nginx e firewall no Debian 12

# ATENÇÃO: Execute como root ou com sudo

# --- CONFIGURAÇÕES QUE VOCÊ DEVE ALTERAR ---
DOMINIO="SEUDOMINIO.com"          # Seu domínio configurado apontando para a VPS proxy
IP_FXSERVER="SEU_IP_FXSERVER_AQUI"     # IP real do servidor FiveM (backend)
IP_VPS_PROXY="IP_DA_VPS_PROXY_AQUI"    # IP da VPS onde este script roda (proxy/cache)
EMAIL_CERTBOT="COLOQUE-SEU-EMAIL-AQUI"   # Email para Certbot (Let's Encrypt)

# --- FIM DAS CONFIGURAÇÕES ---

echo "Atualizando sistema..."
apt update && apt upgrade -y

echo "Instalando nginx, ufw, curl, software-properties-common, certbot..."
apt install -y nginx ufw curl software-properties-common

echo "Configurando UFW (firewall)..."
ufw default deny incoming
ufw default allow outgoing

# Permitir SSH (porta 22)
ufw allow 22/tcp

# Permitir HTTP e HTTPS
sudo ufw allow 'Nginx FULL'

# Permitir acesso ao servidor FiveM apenas do proxy VPS
#ufw allow from $IP_VPS_PROXY to any port 30120 proto tcp
#ufw allow from $IP_VPS_PROXY to any port 30120 proto udp

# Permitir Cloudflare (exemplo básico, ajuste conforme necessidade)
# cf_ips=(173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22)
# for ip in "${cf_ips[@]}"; do
#     ufw allow from $ip to any port 80 proto tcp
#     ufw allow from $ip to any port 443 proto tcp
# done

ufw --force enable

echo "Parando nginx para instalação Certbot..."
systemctl stop nginx

echo "Instalando Certbot e plugin nginx..."
apt install -y certbot python3-certbot-nginx

echo "Iniciando nginx para Certbot..."
systemctl start nginx

echo "Solicitando certificado SSL para $DOMINIO..."
certbot --nginx -d $DOMINIO --email $EMAIL_CERTBOT --agree-tos --non-interactive

echo "Criando arquivo de configuração nginx para proxy FiveM..."

NGINX_CONF="/etc/nginx/sites-available/fivem-proxy.conf"

cat > $NGINX_CONF << EOF
upstream backend {
    server $IP_FXSERVER:30120;
}

proxy_cache_path /srv/cache levels=1:2 keys_zone=assets:48m max_size=20g inactive=2h;

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    server_name $DOMINIO;

    ssl_certificate /etc/letsencrypt/live/$DOMINIO/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMINIO/privkey.pem;

    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options SAMEORIGIN;
    add_header X-XSS-Protection "1; mode=block";
    add_header Referrer-Policy no-referrer-when-downgrade;
    add_header Content-Security-Policy "default-src 'self';";

    location / {
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$remote_addr;
        proxy_pass_request_headers on;
        proxy_http_version 1.1;
        proxy_pass http://backend;
        limit_req zone=one burst=20 nodelay;
    }

    location /files/ {
        proxy_pass http://backend\$request_uri;
        add_header X-Cache-Status \$upstream_cache_status;
        proxy_cache_lock on;
        proxy_cache assets;
        proxy_cache_valid 1y;
        proxy_cache_key \$request_uri\$is_args\$args;
        proxy_cache_revalidate on;
        proxy_cache_min_uses 1;
        limit_req zone=one burst=20 nodelay;
    }
}

EOF

echo "Criando arquivo stream-proxy.conf para proxy TCP/UDP..."

STREAM_CONF="/etc/nginx/stream-proxy.conf"

cat > $STREAM_CONF << EOF
stream {
    upstream backend {
        server $IP_FXSERVER:30120;
    }

    server {
        listen 30120;
        proxy_pass backend;
    }

    server {
        listen 30120 udp reuseport;
        proxy_pass backend;
    }
}
EOF

echo "Incluindo stream-proxy.conf no nginx.conf..."

if ! grep -q "include $STREAM_CONF;" /etc/nginx/nginx.conf; then
    echo "include $STREAM_CONF;" >> /etc/nginx/nginx.conf
fi

echo "Configurando limit_req_zone para rate limiting..."

if ! grep -q "limit_req_zone" /etc/nginx/nginx.conf; then
    sed -i "/http {/a \    limit_req_zone \$binary_remote_addr zone=one:10m rate=10r/s;" /etc/nginx/nginx.conf
fi

echo "Ativando site nginx..."

ln -sf $NGINX_CONF /etc/nginx/sites-enabled/fivem-proxy.conf

echo "Testando configuração nginx..."

nginx -t

echo "Reiniciando nginx..."

systemctl restart nginx

echo "Todas as configurações foram aplicadas."
echo "Lembre-se de editar seu server.cfg do FXServer com as seguintes linhas:"
echo ""
echo "set sv_forceIndirectListing true"
echo "set sv_listingHostOverride $DOMINIO"
echo "set sv_listingIpOverride \"$IP_VPS_PROXY\""
echo "set sv_proxyIPRanges \"$IP_VPS_PROXY/32\""
echo "adhesive_cdnKey \"umaChaveSecretaAleatoria\""
echo "fileserver_add \".*\" \"https://$DOMINIO/files\""
echo ""
echo "Substitua 'umaChaveSecretaAleatoria' por uma chave segura e altere os IPs/domínio conforme seu ambiente."
