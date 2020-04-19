# Aurora & EKS Peering

After installing the AWS CLI. Configure it to use your credentials.

```shell
$ aws configure
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <YOUR_AWS_REGION>
Default output format [None]: json
```

This enables Terraform access to the configuration file and performs operations on your behalf with these security credentials.


```shell
$ terraform init
$ terraform apply
```

It will create the infrastructure like the following: 

https://user-images.githubusercontent.com/6102063/79696267-9cdd2080-8230-11ea-93d0-f7d912c19aa4.png

## Configure kubectl

The following command will get the access credentials for your cluster and automatically
configure `kubectl`.

```shell
$ aws eks --region <region> update-kubeconfig --name <cluster-name>
```

## Aurora endpoint

Create service from EKS to Aurora

```
kubectl apply -f mysql-service.yaml
```

## Test VPC peering

Throw busybox image to the cluster. 

```
kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh
/ # nc mysql-service 3306
N
5.7.26-logR&=lk`xTH???mj    _5#K)>mysql_native_password
```
