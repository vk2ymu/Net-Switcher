# Net-Switcher - Save and select one of two configurations of any mix by VK2YMU 

#Assign GPIO PIN
gpio mode 7 in
        # Make file system read & write
        mount -o remount,rw /

        # Create Configs if it does not exist
        if [ ! -d /home/pi-star/configs ];
        then
                mkdir /home/pi-star/configs
        fi
# Cold Start setup - Loading correct config relative to switch position
        b=$(gpio read 7)
        if [ $b -eq 1 ]
        then
                cp /home/pi-star/configs/p25gatewaycfg2 /etc/p25gateway
                cp /home/pi-star/configs/nxdngatewaycfg2 /etc/nxdngateway
                cp /home/pi-star/configs/dmrgatewaycfg2 /etc/dmrgateway
                cd /home/pi-star/configs/dmr2nxdncfg2 /etc/dmr2nxdn
                cd /home/pi-star/configs/dmr2ysfcfg2 /etc/dmr2ysf
                cp /home/pi-star/configs/cfg2 /etc/mmdvmhost
                cp /home/pi-star/configs/ysfgatewaycfg2 /etc/ysfgateway
                cp /home/pi-star/configs/ysf2p25cfg2 /etc/ysf2p25
                cp /home/pi-star/configs/ysf2dmrcfg2 /etc/ysf2dmr
                cp /home/pi-star/configs/ysf2nxdncfg2 /etc/ysf2nxdn

        fi
        if [ $b -eq 0 ]
        then
                cp /home/pi-star/configs/p25gatewaycfg1 /etc/p25gateway
                cp /home/pi-star/configs/nxdngatewaycfg1 /etc/nxdngateway
                cp /home/pi-star/configs/dmrgatewaycfg1 /etc/dmrgateway
                cd /home/pi-star/configs/dmr2nxdncfg1 /etc/dmr2nxdn
                cd /home/pi-star/configs/dmr2ysfcfg1 /etc/dmr2ysf
                cp /home/pi-star/configs/cfg1 /etc/mmdvmhost
                cp /home/pi-star/configs/ysfgatewaycfg1 /etc/ysfgateway
                cp /home/pi-star/configs/ysf2p25cfg1 /etc/ysf2p25
                cp /home/pi-star/configs/ysf2dmrcfg1 /etc/ysf2dmr
                cp /home/pi-star/configs/ysf2nxdncfg1 /etc/ysf2nxdn
        fi
        # Restart services
        systemctl restart dmrgateway.service
        systemctl restart nxdngateway.service
        systemctl restart p25gateway.service
        systemctl restart ysfgateway.service
        systemctl restart ysf2dmr.service
        systemctl restart ysf2nxdn.service
        systemctl restart ysf2p25.service
        systemctl restart mmdvmhost.service
        sleep 1
        
        # Make File system read only
        mount -o remount,ro /

# Save last key position after cold start
lastVal=$b

# Endless Loop
while : 
do
        # Has Switch been operated ?
        b=$(gpio read 7)
        if [ $b != $lastVal ]
        then
                # Read Switch position
                lastVal=$b

                # Make file system Read & write if key change
                mount -o remount,rw /
                if [ $b -eq 1 ]
                then
                        echo "cfg2 mode"
                        cp /etc/mmdvmhost /home/pi-star/configs/cfg1
                        cp /etc/dmr2ysf /home/pi-star/configs/dmr2ysfcfg1
                        cp /etc/dmr2nxdn /home/pi-star/configs/dmr2nxdncfg1
                        cp /etc/ysf2p25 /home/pi-star/configs/ysf2p25cfg1
                        cp /etc/ysf2dmr /home/pi-star/configs/ysf2dmrcfg1
                        cp /etc/ysf2nxdn /home/pi-star/configs/ysf2nxdncfg1
                        cp /etc/ysfgateway /home/pi-star/configs/ysfgatewaycfg1
                        cp /etc/p25gateway /home/pi-star/configs/p25gatewaycfg1
                        cp /etc/nxdngateway /home/pi-star/configs/nxdngatewaycfg1
                        cp /etc/dmrgateway /home/pi-star/configs/dmrgatewaycfg1
                    
                    
                        echo "Saved cfg1"

                        echo " "
                        cp /home/pi-star/configs/cfg2 /etc/mmdvmhost
                        cp /home/pi-star/configs/dmr2ysfcfg2 /etc/dmr2ysf
                        cp /home/pi-star/configs/dmr2nxdncfg2 /etc/dmr2nxdn
                        cp /home/pi-star/configs/ysf2p25cfg2 /etc/ysf2p25
                        cp /home/pi-star/configs/ysf2dmrcfg2 /etc/ysf2dmr
                        cp /home/pi-star/configs/ysf2nxdncfg2 /etc/ysf2nxdn
                        cp /home/pi-star/configs/ysfgatewaycfg2 /etc/ysfgateway
                        cp /home/pi-star/configs/p25gatewaycfg2 /etc/p25gateway
                        cp /home/pi-star/configs/nxdngatewaycfg2 /etc/nxdngateway
                        cp /home/pi-star/configs/dmrgatewaycfg2 /etc/dmrgateway

                fi
                if [ $b -eq 0 ]
                then
                        echo "cfg1 mode "
                        cp /etc/mmdvmhost /home/pi-star/configs/cfg2
                        cp /etc/dmr2ysf /home/pi-star/configs/dmr2ysfcfg2
                        cp /etc/dmr2nxdn /home/pi-star/configs/dmr2nxdncfg2
                        cp /etc/ysf2p25 /home/pi-star/configs/ysf2p25cfg2
                        cp /etc/ysf2dmr /home/pi-star/configs/ysf2dmrcfg2
                        cp /etc/ysf2nxdn /home/pi-star/configs/ysf2nxdncfg2
                        cp /etc/ysfgateway /home/pi-star/configs/ysfgatewaycfg2
                        cp /etc/p25gateway /home/pi-star/configs/p25gatewaycfg2
                        cp /etc/nxdngateway /home/pi-star/configs/nxdngatewaycfg2
                        cp /etc/dmrgateway /home/pi-star/configs/dmrgatewaycfg2
                        
                        echo "Saved cfg2 "

                        echo " "
                        cp /home/pi-star/configs/cfg1 /etc/mmdvmhost
                        cp /home/pi-star/configs/dmr2ysfcfg1 /etc/dmr2ysf
                        cp /home/pi-star/configs/dmr2nxdncfg1 /etc/dmr2nxdn
                        cp /home/pi-star/configs/ysf2p25cfg1 /etc/ysf2p25
                        cp /home/pi-star/configs/ysf2dmrcfg1 /etc/ysf2dmr
                        cp /home/pi-star/configs/ysf2nxdncfg1 /etc/ysf2nxdn
                        cp /home/pi-star/configs/ysfgatewaycfg1 /etc/ysfgateway
                        cp /home/pi-star/configs/p25gatewaycfg1 /etc/p25gateway
                        cp /home/pi-star/configs/nxdngatewaycfg1 /etc/nxdngateway
                        cp /home/pi-star/configs/dmrgatewaycfg1 /etc/dmrgateway

                fi

        # Make File system read only
        mount -o remount,ro /

        # Restarting services
        systemctl restart dmrgateway.service
        systemctl restart nxdngateway.service
        systemctl restart p25gateway.service
        systemctl restart ysfgateway.service
        systemctl restart ysf2dmr.service
        systemctl restart ysf2nxdn.service
        systemctl restart ysf2p25.service
        systemctl restart mmdvmhost.service
        sleep 1

        echo " "
        echo "Services started"

fi

        sleep 1
done
