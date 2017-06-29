# Reconsnet

Website e intranet da Reconscientia


## Sugestão de setup em produção para Ubuntu

1. Instalar postgresql `apt-get install postgresql postgresql-server-dev-all`
1. Instalar redis `apt-get install redis-server`
1. Instalar nginx `apt-get install nginx`
1. Instalar Ruby >= 2.4 (sugestão: instalar usando http://rvm.io)
1. Git checkout do `reconsnet`
1. `gem install bundler`
1. cd reconsnet/
1. `bundle install`
1. Criar um usuario local do PostgreSQL e configurar as credenciais via variaveis de ambiente (ver [tutorial](https://www.vivaolinux.com.br/dica/Criacao-de-1edeg;-super-usuario-no-PostgreSQL))
1. `export RAILS_ENV=production`
1. `rails db:create`
1. `rails db:migrate`
1. `rails db:seed`
1. `./bin/assets_precompile`
1. Criar arquivo `config/reconsnet.yml` com a estrutura abaixo a preencher com os valores apropriados:
    ```yaml
    production:
      mailchimp_list_id:
      mailchimp_api_key:
      smtp_username:
      smtp_password:
      dumperio_key:
    development:
      mailchimp_list_id:
      mailchimp_api_key:
      smtp_username:
      smtp_password:
      dumperio_key:
    test:
      mailchimp_list_id:
      mailchimp_api_key:
      smtp_username:
      smtp_password:
      dumperio_key:
     ```
1. Configurar nginx. Ver exemplo de arquivo de configuração abaixo
1. Colocar para rodar: `rails s`
1. Criação de primeiro usuário com permissão de 'admin'
    1. Acesse `http://meuhost.com/users/sign_up`
    1. No rails console (`rails c -e production`): 
        1. `user = User.find_by(email: 'meuemail@email.com')`
        1. `user.add_role :admin`
1. Para permitir que a integração com o MailChimp funcione, é necessário iniciar o Sidekiq
    1. Em um terminal `screen` próprio, iniciar o serviço executando `RAILS_ENV=production bundle exec sidekiq`



## Informações em mais detalhes

### Integração com MailChimp

Sempre que uma pessoa é adiciona ou removida, seu email é adicionado (ou removido) de uma lista de divulgação
especificada (`mailchimp_list_id`). É possível também ter a pessoa cadastrada no sistema e não na lista de emails,
bastando para isso selecionar 'Não deseja receber divulgação' no cadastro da pessoa em questão.

### Integração com um "SMTP em cloud" para envio de emails do sistema

E-mails para reset de senha ou possíveis notificações sobre atividades no sistema dependem da configuração de 
um servidor SMTP, seja em servidor próprio ou usando um serviço em Cloud. Recomendamos o uso do serviço em cloud 
[mailgun](http://mailgun.com) por ser simples de usar e permitir o envio de muitos emails mesmo na conta gratuita.

### Sidekiq e Redis

Sidekiq é uma biblioteca para Ruby/Rails que permite a execução de jobs de maneira asyncrona em segundo plano 
e para funcionar que usa o [redis](http://redis.io) como "backend". No momento o sidekiq é usado para interagir com a API do 
MailChimp para adição/remoção de emails da lista de divulgação.


### Dumper.io

Dumper.io é um serviço muito simples e prático para backup do banco de dados. Recomenda-se criar uma conta
neste serviço [dumper.io](http://dumper.io) e para os backups automáticos do banco começarem a funcionar basta especificar o `dumperio_key` em 
`config/reconsnet.yml`.

### Arquivo de configuração para nginx

Exemplo de arquivo de configuração da intranet/site reconsnet para nginx em Ubuntu. 
Adiciona-lo em `/etc/nginx/sites-enabled`

```
upstream reconsnet {
   server unix:/tmp/reconsnet_app.sock;
}

server {
 listen 80;
 server_name reconscientia.org www.reconscientia.org;

 client_max_body_size 15M;

 try_files $uri/index.html $uri @reconsnet;
 root /home/reconsnet/reconsnet/public;

 location @reconsnet {
      #proxy_read_timeout 300;
      #proxy_connect_timeout 300;
      proxy_redirect off;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_set_header Host $http_host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_pass http://reconsnet;
    }

  error_page 500 504 /500.html;
  error_page 502 /502.html;
  error_page 503 /503.html;

}
```