# Epitech workshop - Terraform

## Setup

```
wget https://releases.hashicorp.com/terraform/0.11.4/terraform_0.11.4_linux_amd64.zip
unzip terraform_0.11.4_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

Please create a Digital Ocean account (10$ free credit with this link: https://m.do.co/c/1670fd3e0af6).

Create and upload a SSH key to Digital Ocean: https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-digitalocean-droplets

For the workshopt, you will need your SSH fingerprint:

```
ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub | awk '{print $2}' | sed 's#MD5:##'
```

Create a token for contacting API: https://cloud.digitalocean.com/settings/api/tokens

## Doc

Great (awesome!) documentation available here: https://www.terraform.io/docs/providers/index.html

## Let's go

### Step #1: Create a VM ("droplet") in NYC, with 512 MB of memory and based on debian

<details>
  <summary>Hint:</summary>

  ```
  # first
  terraform init
  # then
  terraform plan
  terraform apply
  ```

</details>

Can you access the VM by SSH ?

### Step #2: Upgrade memory to 1GB

<details>
  <summary>Hint:</summary>

  ```
  terraform plan
  terraform apply
  ```

</details>

### Step #3: Sorry, I was wrong: I need you to move the VM to London ;)

<details>
  <summary>What just happened ?</summary>
  Droplet has been flagged for remove+create ("forces new resource").
</details>

### Step #4: If this is not already done, move your Digital Ocean token into a terraform variable.

### Step #5: If this is not already done, move your Digital Ocean token into an environement variable.

<details>
  <summary>Hint:</summary>

  RTFM:

  https://www.terraform.io/docs/configuration/environment-variables.html

  ![](http://grammota.com/sites/default/files/2017-07/shto-takoe-rtfm-2.jpg)
</details>

🙏 Never ever commit auth token !! 🙏

### Step #6: Output ipv4, disk size and hourly price of the Droplet

<details>
  <summary>Hint:</summary>

  RTFM:

  https://www.terraform.io/docs/providers/do/r/droplet.html

  ```
  terraform output
  ```

  ![](http://i0.kym-cdn.com/photos/images/original/000/131/662/22711800_646849b145.jpg)

</details>

### Step #7: Destroy your instance from Terraform

<details>
  <summary>Hint:</summary>

  RTFM

  ```
  terraform help
  ```

  ![](https://static1.squarespace.com/static/54bcbd06e4b060f2e987ebbe/t/56fea9a44d088ed7bb3334af/1459530161285/)

</details>

### Step #8: With only 1 Terraform resource, create 42 droplets with the same config for both.

<details>
  <summary>Hint:</summary>

  ![](https://media.giphy.com/media/iM2zk4rboByQE/giphy.gif)

</details>

Output must display every ipv4.

Then destroy those droplets ASAP (42 VM == $$$).

### Step #9: With only 1 Terraform resource, create 2 instances with the "docker-16-04" official image.

The first droplet must be called "web-0" and the second "web-1".

With Terraform, ask DO to run a Docker container after droplet boot:

```
resource "digitalocean_droplet" "webs" {

  ...

  provisioner "remote-exec" {
    inline = [
      "docker run -d -p 8080:80 -h $(hostname) iadvize/hello-world"
    ]
  }

  ...

}
```

The Docker container will expose the VM hostname on port 8080.

Open http://<ip-web-0>:8080 and http://<ip-web-1>:8080 in your browser. You will see respective hostnames.

### Step #10: With a Terraform resource, add a load balancer in front of both servers (on port 8080).

You must have only 2 resources in your terraform config.

A HTTP healthcheck on port 8080 may work perfectly.

Please output the load balancer ip.

<details>
  <summary>Hint:</summary>

  ```
  digitalocean_loadbalancer
  ```

</details>

If you open http://<load-balancer-ip>:8080 and refresh many times, do you see the hostname changing ?

### Step #11: Region is hard-coded in digitalocean_droplet and digitalocean_loadbalancer. Can you create a variable ?

### Step #12: Print a svg graph of Terraform resources

<details>
  <summary>Hint:</summary>

  ```
  terraform graph --help
  ```

  https://www.terraform.io/docs/commands/graph.html
</details>

After that step, destroy VM and LB please.

### Step #13: Now, I would like 2 droplets + 1 load balancer in 2 environments: "staging" and "prod".

Don't duplicate resources !

Please call your servers differently: web_prod_x and web_staging_x.

<details>
  <summary>Hint:</summary>

  ```
  terraform workspace --help
  ```

  and

  ```
  ${terraform.workspace}
  ```

</details>

### Step #42: Check in Digital Ocean console that you removed everything ;)

💰💰💰💰💰

I may upload a complete Terraform config after workshop.

...or maybe not ;)
