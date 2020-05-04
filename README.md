# [🕄]

![Double triangular probability distribution function][dtpdf]

3PE IaaS PoC: a [three-point estimation][1] calculator (but with [proper
calculations for the double-triangular distribution][2] instead of the
simplified hogwash on Wikipedia) showcasing automatic provisioning and
deployment.

A hobby project to try out [Vagrant], [Terraform], [AWS] and
[Github Actions].

---

## Frontend

* HTML5 SPA built with [Vue.js]. (Or possibly just jQuery.)
  * Simple table with functionality:
    * Add row with work package name.
    * Update row with best-case, most-likely, worst-case estimates.
    * Delete row.
  * Output below table:
    * Best estimate (95% confidence interval).
    * [Plotly] box plot of confidence intervals.
  * Button to select Lambda backend.
* Data stored in browser local storage.
* Load estimate from URL slug.
* Send estimate as permalink in an email.
* Served by an [nginx] container running in Amazon EC2.
* Some functionality available offline with [UpUp].

## Backend

* Calculates a three-point estimate based on an array of three-tuples.
* Implemented in Java, Go, Node.js, C#, Python and Ruby. Perl?
* Deployed as AWS Lambda functions.

## Other services

* [Mailgun] to send the estimate to a friend.
* [Open Distro for Elasticsearch] (on Amazon) for logging.
* [Sonarcloud] for static code analysis and QA.

---

## Baby Steps

### 0. Prerequisites

This guide assumes you have:

* Windows 10 Pro with [Hyper-V enabled][3] and configured with a virtual bridge
* [Vagrant] 2.2.7 installed with the vagrant-env plugin (`vagrant plugin install vagrant-env`)

If you want to use Vagrant Share, you also need the [ngrok] executable somewhere
on your `%PATH%`.

### 1. Vagrant

Vagrant is used to create a consistent development environment. Before the first
run - which will provision the developer VM - you need to fill in the values in
the `.env.template` file and rename it to `.env`.

To launch the developer VM on Windows 10, now simply

```bash
vagrant up --provider=hyperv
vagrant ssh
```

in the root dir. When you boot up the image, you will get a message asking for
your Windows credentials to mount SMB shares. Enter your username as
`user@domain`.

Make a note of the line that says `default: IP: 192.168.nnn.nnn`. When the
guest VM is ready, open <http://192.168.nnn.nnn> in a browser on your host
machine to verify that you can access the web server.

You can now edit the code in the `frontend` directory and immediately see your
changes in the browser (F5, natch).

The development VM is an Ubuntu 18.04 image with an nginx web server serving
the `frontend` directory through a symlink, configured in the `Vagrantfile`.

<!--
To install Vagrant Share and share your dev web server with the world, just

```bash
vagrant plugin install vagrant-share
vagrant share --http 4567
```
-->

### 2. AWS

To run the **λ** functions you need an execution role. Open the [roles page] in
the IAM console and click *Create role*:

* Choose the Lambda use case
* Pick **AWSLambdaBasicExecutionRole**
* No tags
* Name the role `lambda-execution-role`

### AWS

* `eu-north-1`
* `ami-09c69c3a9e3578c8d`

[1]:https://en.wikipedia.org/wiki/Three-point_estimation
[2]:https://www.mhnederlof.nl/doubletriangular.html
[3]:https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v
[AWS]:https://aws.amazon.com/
[dtpdf]:http://www.mhnederlof.nl/images/doubletriangular.jpg
[Github Actions]:https://github.com/features/actions
[Mailgun]:https://mailgun.com/
[nginx]:https://nginx.com/
[ngrok]:https://ngrok.com/
[Open Distro for Elasticsearch]:https://opendistro.github.io/for-elasticsearch/
[Plotly]:https://plotly.com/javascript/box-plots/
[roles page]:https://console.aws.amazon.com/iam/home#/roles
[Sonarcloud]:https://sonarcloud.io/
[Terraform]:https://terraform.io/
[UpUp]:https://github.com/TalAter/UpUp
[Vagrant]:https://www.vagrantup.com/
[Vue.js]:https://vuejs.org/
