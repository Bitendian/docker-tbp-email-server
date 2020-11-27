# Email Server

La imagen parte de una distribución **debian-slim** con [postfix](http://www.postfix.org/) y [mailutils](https://mailutils.org/) preinstalados.

Se dispone de 3 parámetros para configurar **postfix** que se pasan como variables de entorno al contenedor:
- **POSTFIX_MYHOSTNAME**: FQDN de este sistema de correo: _host.example.com_
- **POSTFIX_MYDESTINATION**: Lista de dominios separados por comas o espacios en blanco de los que se acepta correo entrante y se envia al buzón de correo local del servidor
- **POSTFIX_MYDOMAIN**: Nombre de dominio de este sistema de correo: _example.com_

**Documentación de postfix:** http://www.postfix.org/basic_configuration_readme.html

### Docker Compose

Para añadir el servidor de correo a un despliegue con **docker-compose**, el servicio se define de la siguiente manera, configurando las variables de entorno, red y nombre del contenedor a conveniencia: 

``` 
  bitendian-email-server:
    image: bitendian/tbp-email-server:latest
    container_name: 'bitendian-email-server'
    restart: 'always'
    networks:
      - bitendian-internal
    environment:
      POSTFIX_MYHOSTNAME: no-reply.bitendian.com
      POSTFIX_MYDESTINATION: localhost
      POSTFIX_MYDOMAIN: bitendian.com
```


### Docker run

Para ejecutar la imagen y añadir el contenedor a una red existente:

```
docker run -e POSTFIX_MYHOSTNAME=no-reply.bitendian.com \
           -e POSTFIX_MYDESTINATION=localhost \
           -e POSTFIX_MYDOMAIN=bitendian.com \
           --name=bitendian-email-server --network=bitendian-internal bitendian/tbp-email-server:latest
```
**Importante:** El nombre del cotenedor es el que se tendrá que configurar como host de correo en la aplicación donde se incorpore el servidor 
