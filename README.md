# [🕄]

3PE IaaS PoC: a [three-point estimation] calculator showcasing automatic
provisioning and deployment.

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
* Send estimate as permalink in an email.s
* Served by an [nginx] container running in Amazon EC2.

## Backend

* Calculates a three-point estimate based on an array of three-tuples.
* Implemented in Java, Go, Node.js, C#, Python and Ruby. Perl?
* Deployed as AWS Lambda functions.

## Other services

* [Mailgun] to send the estimate to a friend.
* [Open Distro for Elasticsearch] for logging - remember there's an Amazon
  special.
* [Sonarcloud] for static code analysis and QA.

---

## Baby Steps

### 0. Prerequisites

This guide assumes Windows 10 Pro with [Hyper-V enabled] and configured with a
virtual bridge.

If you want to use Vagrant Share, you also need the [ngrok] executable
somewhere on your `%PATH%`.

### 1. Vagrant

[Vagrant] is used to provision a consistent development environment. To launch
the developer VM on Windows 10, simply

```bash
vagrant up --provider=hyperv
vagrant ssh
```

in the root dir. When you boot up the image, you will get a message asking for
your Windows credentials to mount SMB shares. Enter your username as
`user@domain`.

### AWS

* `eu-north-1`
* `ami-09c69c3a9e3578c8d`

[AWS]:https://aws.amazon.com/
[Hyper-V enabled]:https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v
[Github Actions]:https://github.com/features/actions
[Mailgun]:https://mailgun.com/
[nginx]:https://nginx.com/
[ngrok]:https://ngrok.com/
[Open Distro for Elasticsearch]:https://opendistro.github.io/for-elasticsearch/
[Plotly]:https://plotly.com/javascript/box-plots/
[Sonarcloud]:https://sonarcloud.io/
[Terraform]:https://terraform.io/
[three-point estimation]:https://en.wikipedia.org/wiki/Three-point_estimation
[Vagrant]:https://www.vagrantup.com/
[Vue.js]:https://vuejs.org/
