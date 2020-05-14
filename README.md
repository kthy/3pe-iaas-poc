# [🕄]

![Double triangular probability distribution function][dtpdf]

3PE IaaS PoC: a [three-point estimation][1] calculator (but with [proper
calculations for the double-triangular distribution][2] instead of the
simplified hogwash on Wikipedia) showcasing automatic provisioning and
deployment.

A hobby project to try out [Vagrant], [Terraform], [AWS] and
[Github Actions].

---

## ⚠️ WIP ⚠️

This is a work in progress. By one person. In his spare time. **Caveat emptor!**

---

## Frontend

* HTML5 SPA ([12-Factor]) built with [Bootstrap].
  * Color palette: https://coolors.co/334139-533b4d-b5dfaf-e574bc-f51aa4
  * Simple table with functionality:
    * Add row with work package name.
    * Update row with best-case, most-likely, worst-case estimates.
    * Delete row.
  * Output below table:
    * Best estimate (95% confidence interval).
    * [Plotly] box plot of confidence intervals.
  * Button to select Lambda backend.
* Data stored in browser local storage or [Redis] (user choice).
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

This guide assumes you have

* Windows 10 Pro,
* [Hyper-V enabled][3] and configured with a virtual bridge, and
* [Vagrant] 2.2.x installed.

If you want to use Vagrant Share, you also need the [ngrok] executable somewhere
on your `%PATH%`.

### 1. Vagrant

Vagrant is used to create a consistent development environment. Before the first
run — which will provision the developer VM — you need to fill in the missing
values in the `.env.template` file and rename it to `.env`. Enter your Windows
username as `user@domain`. Pick a canonical timezone name from the [tzdata list]
as the value for `TZ`, or remove the key to run the environment on UTC.

The development VM is an [Alpine] 3.11 image with an nginx web server serving
the `frontend` directory through a symlink, configured in the `Vagrantfile`.
If the `AWS_*` keys are set in your `.env` file, it will also have the AWS CLI
installed.

To launch and use the developer VM, now simply `vagrant up` in the root dir.
When the guest VM is ready, open the URL in the last line of the install log in
a browser on your host machine to verify that you can access the web server.

You can now edit the code in the `frontend` directory and immediately see your
changes in the browser (F5, natch).

<!--
To share your dev web server with the world through Vagrant Share, just
`vagrant share --http 4567`.
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
[12-Factor]:https://12factor.net/
[AWS]:https://aws.amazon.com/
[Bootstrap]:https://getbootstrap.com/
[dtpdf]:http://www.mhnederlof.nl/images/doubletriangular.jpg
[Github Actions]:https://github.com/features/actions
[Mailgun]:https://mailgun.com/
[nginx]:https://nginx.com/
[ngrok]:https://ngrok.com/
[Open Distro for Elasticsearch]:https://opendistro.github.io/for-elasticsearch/
[Plotly]:https://plotly.com/javascript/box-plots/
[Redis]:https://redis.io/
[roles page]:https://console.aws.amazon.com/iam/home#/roles
[Sonarcloud]:https://sonarcloud.io/
[Terraform]:https://terraform.io/
[tzdata list]:https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
[UpUp]:https://github.com/TalAter/UpUp
[Vagrant]:https://www.vagrantup.com/
