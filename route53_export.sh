#!/bin/bash
#
# Script to export Route53 Hosted Zone records
#
#####################################

# Var
dir=r53exports/
export1=metabeds.com.r53.sec
export2=onedmc.com.r53.sec
export3=seeraspain.com.r53.sec
export4=b2b-pro.internal.r53.sec


# Main
echo "O=> Exporting AWS Route53 Hosted Zones from PRODUCTION account..."
echo
echo "exporting metabeds.com route53 zone to $dir$export1 file"
echo " O=> METABEDS.COM route53 export zone records:" > $dir$export1
aws route53 list-resource-record-sets --hosted-zone-id Z3VA91PTLV796P --profile prod >> $dir$export1 
echo
echo "exporting onedmc.com route53 zone to $dir$export2 file"
echo " O=> ONEDMC.COM route53 export zone records:" > $dir$export2
aws route53 list-resource-record-sets --hosted-zone-id Z09644901SVHEDT4DTIDB --profile prod >> $dir$export2 
echo
echo "exporting seeraspain.com route53 zone to $dir$export3 file"
echo " O=> SEERASPAIN.COM route53 export zone records:" > $dir$export3
aws route53 list-resource-record-sets --hosted-zone-id Z2IFVLZOXETW6Q --profile prod >> $dir$export3 
echo
echo "exporting b2b-pro.internal route53 zone to $dir$export4 file"
echo " O=> B2B-PRO.INTERNAL route53 export zone records:" > $dir$export4
aws route53 list-resource-record-sets --hosted-zone-id Z05931543KX7SG974XVNP --profile prod >> $dir$export4 
echo
echo "o=> All AWS Route53 Hosted Zones from PRODUCTION account have been exported to \".sec\" txt files in $dir."
# End

