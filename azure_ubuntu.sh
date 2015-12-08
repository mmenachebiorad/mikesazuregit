#!/bin/sh

LOCATION="Central US"

AFFINITYGROUP="MyLinuxDemo"
STORAGEACCOUNT="mylinuxdemo"
ADDRESSSPACE="10.0.0.0"
ADDRESSSPACECIDR="8"
SUBNETADDRESSSPACE="10.0.0.0"
SUBNETADDRESSSPACECIDR="24"
SUBNETNAME="Subnet01"
VNETNAME="MyLinuxVNet"
CLOUDSERVICENAME="MyCloudLinuxService"

IMAGENAME="b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_3-LTS-amd64-server-20151105-en-us-30GB"
USERNAME="mmenache"
USERPASSWORD="Mm3nach3!"
SSHPORT="22001"
VMNAME="Linux01"


#create affinity group
azure account affinity-group create --location "$LOCATION" --label $AFFINITYGROUP $AFFINITYGROUP

#create storage account
azure storage account create --affinity-group
$AFFINITYGROUP $STORAGEACCOUNT

#create virtual network
azure network vnet create --affinity-group
$AFFINITYGROUP --address-space $ADDRESSSPACE --cidr
$ADDRESSSPACECIDR --subnet-start-ip
$SUBNETADDRESSSPACE --subnet-cidr
$SUBNETADDRESSSPACECIDR --subnet-name $SUBNETNAME
$VNETNAME

#create cloud service
azure service create --affinitygroup $AFFINITYGROUP
$CLOUDSERVICENAME

#create virtual machine
azure vm create $CLOUDSERVICENAME $IMAGENAME
$USERNAME "$USERPASSWORD"  --ssh $SSHPORT --vn-name $VMNAME
--virtual-network-name $VNETNAME --subnet-names $SUBNETNAME --blob-url "https://${STORAGEACCOUNT}.blob.core.windows.net/hdd/${VMNAME}-system"