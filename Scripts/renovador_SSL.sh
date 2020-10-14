#!/bin/bash

# Cuantos dias antes de vencer se debe renovar el certificado
dias=13

# Corre el comando certificates y filtra la palabra VALID: y toma los dias para comparar en el if
certbot certificates | grep 'VALID:' | awk '{print $6}' | while read output;
do

  if [ "$output" == "$dias" ];
   then
   echo "El certificado se renovara"
   certbot -q renew --post-hook "systemctl restart nginx"
  else
   echo "El certificado vence en $output"
  fi
done
