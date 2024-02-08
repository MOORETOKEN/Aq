echo 'if [ "$NETWORK" == "mainnet-beta" ]; then' >> setup_solana.sh
echo 'SWAPSIZE=300' >> setup_solana.sh
echo 'SWAPSIZE2=250' >> setup_solana.sh
echo 'elif [ "$NETWORK" == "testnet" ]; then' >> setup_solana.sh
echo 'SWAPSIZE=160' >> setup_solana.sh
echo 'SWAPSIZE2=120' >> setup_solana.sh
echo 'fi' >> setup_solana.sh
echo '' >> setup_solana.sh
echo 'printf "${C_LGn}Enter the swap size [$SWAPSIZE]:${RES} "' >> setup_solana.sh
echo 'read -r SWAPSIZE_INPUT' >> setup_solana.sh
echo 'if [ -n "$SWAPSIZE_INPUT" ]; then' >> setup_solana.sh
echo 'SWAPSIZE=$SWAPSIZE_INPUT' >> setup_solana.sh
echo 'fi' >> setup_solana.sh
echo '' >> setup_solana.sh
echo 'printf "${C_LGn}Enter the ramdisk size [$SWAPSIZE2]:${RES} "' >> setup_solana.sh
echo 'read -r SWAPSIZE2_INPUT' >> setup_solana.sh
echo 'if [ -n "$SWAPSIZE2_INPUT" ]; then' >> setup_solana.sh
echo 'SWAPSIZE2=$SWAPSIZE2_INPUT' >> setup_solana.sh
echo 'fi' >> setup_solana.sh
echo '' >> setup_solana.sh
echo 'ln -sf /root/solana/validator-keypair.json /root/solana/identity.json' >> setup_solana.sh
echo '' >> setup_solana.sh
echo 'cat > /root/solana/solana.logrotate <<EOF' >> setup_solana.sh
echo '/root/solana/solana.log {' >> setup_solana.sh
echo '  rotate 7' >> setup_solana.sh
echo '  daily' >> setup_solana.sh
echo '  missingok' >> setup_solana.sh
echo '  postrotate' >> setup_solana.sh
echo '    systemctl kill -s USR1 solana.service' >> setup_solana.sh
echo '  endscript' >> setup_solana.sh
echo '}' >> setup_solana.sh
echo 'EOF' >> setup_solana.sh
echo '' >> setup_solana.sh
echo 'printf "${C_LGn}Should we create SWAP one more time? [Y/n]:${RES} "' >> setup_solana.sh
echo 'read -r SWAP_CREATE_INPUT' >> setup_solana.sh
echo 'case "$SWAP_CREATE_INPUT" in' >> setup_solana.sh
echo '    [nN]) ' >> setup_solana.sh
echo '    echo "not creating swap one more time"' >> setup_solana.sh
echo '        ;;' >> setup_solana.sh
echo '    *)' >> setup_solana.sh
echo '    swapoff -a' >> setup_solana.sh
echo '    dd if=/dev/zero of=$SWAP_PATH bs=1G count=$SWAPSIZE' >> setup_solana.sh
echo '    chmod 600 $SWAP_PATH' >> setup_solana.sh
echo '    mkswap $SWAP_PATH' >> setup_solana.sh
echo '    swapon $SWAP_PATH' >> setup_solana.sh
echo '' >> setup_solana.sh
echo '    # delete other swaps from /etc/fstab' >> setup_solana.sh
echo '    sed -e '/swap/s/^/#\ /' -i_backup /etc/fstab' >> setup_solana.sh
echo '' >> setup_solana.sh
echo '    ## add to /etc/fstab' >> setup_solana.sh
echo '    echo $SWAP_PATH none swap sw 0 0 >> /etc/fstab' >> setup_solana.sh
echo '        ;;' >> setup_solana.sh
echo 'esac' >> setup_solana.sh
