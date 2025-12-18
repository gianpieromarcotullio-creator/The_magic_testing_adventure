FROM osixia/openldap:latest

# Impostiamo le variabili d'ambiente di default per questa immagine
# Così non devi scriverle ogni volta che lanci il container
ENV LDAP_ORGANISATION="Galactica"
ENV LDAP_DOMAIN="galactica.local"
ENV LDAP_BASE_DN="dc=galactica,dc=local"

# Copiamo il file LDIF nella cartella speciale di bootstrap
# Tutto ciò che è qui dentro viene aggiunto al database all'avvio
COPY bootstrap.ldif /container/service/slapd/assets/config/bootstrap/ldif/custom/50-bootstrap.ldif
