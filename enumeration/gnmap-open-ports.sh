# Este script recibe un fichero .gnmap como argumento, y extrae una lista de puertos abiertos.
# Útil para usar en combinación de: nmap -v -p $(bash ~/j4ckmln/tools/hackingpotions/gnmap-open-ports.sh quick-full-tcp.gnmap) -T4 -A --script=default,vuln -oA scripts-full-tcp -iL ../ip.txt
# Utilización: bash gnmap-open-ports.sh <fichero .gnmap>

# Fichero como argumento
GNMAP_FILE=$1

# Filtrado de información
ports=$(egrep -v "^#|Status: Up" $GNMAP_FILE | cut -d' ' -f2,4- | \
sed -n -e 's/Ignored.*//p'  | \
awk '{print "Host: " $1 " Ports: " NF-1; $1=""; for(i=2; i<=NF; i++) { a=a" "$i; }; split(a,s,","); for(e in s) { split(s[e],v,"/"); printf "%-8s %s/%-7s %s\n" , v[2], v[3], v[1], v[5]}; a="" }' | grep tcp | awk {'print $3'} | tr '\n' ',')

# Lista de puertos
echo ${ports: : -1}

# Ejemplo de output: 21,80,443,445,3389,8080