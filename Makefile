# Verifica se o arquivo .env existe no projeto. Caso não exista, mata a execução do script.
ENV_FILE=./.env
ifeq ("$(wildcard $(ENV_FILE))","")
$(error Arquivo .env não encontrado.)
endif

# Exporta todas variáveis do arquivo .env para variáveis de ambiente em tempo
# de execução, ou seja, somente durante o uso do script.
include .env
export

# Certbot ----------------------------------------------------------------------

register-ssl-staging:
	@chmod +x ./bin/certbot/register-ssl.sh
	@sudo ./bin/certbot/register-ssl.sh \
								--dominios "$(DOMINIOS)" \
								--email $(EMAIL) \
								--staging

register-ssl:
	@chmod +x ./bin/certbot/register-ssl.sh
	@sudo ./bin/certbot/register-ssl.sh \
								--dominios "$(DOMINIOS)" \
								--email $(EMAIL) \
								--flush

# Demais Comandos --------------------------------------------------------------

start-test: 
	docker-compose up

start: 
	docker-compose up -d

stop:
	docker-compose down

restart:
	docker-compose restart
