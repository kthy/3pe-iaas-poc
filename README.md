# [🕄]

3PE IaaS PoC: a
[three-point estimation](https://en.wikipedia.org/wiki/Three-point_estimation)
calculator with automatic provisioning and deployment.

A hobby project to try out [Terraform](https://terraform.io/),
[AWS](https://aws.amazon.com/) and
[Github Actions](https://github.com/features/actions).

## Frontend

* HTML5 SPA built with [Vue.js](https://vuejs.org/).
  * Simple table with functionality:
    * Add row with work package name.
    * Update row with best-case, most-likely, worst-case estimates.
    * Delete row.
  * Output below table:
    * Best estimate (95% confidence interval).
    * [Plotly](https://plotly.com/javascript/box-plots/) box plot of confidence
      intervals.
  * Button to select Lambda backend.
* Data stored in browser local storage.
* Served by an [nginx](https://nginx.com/) container running in EC2.

## Backend

* Calculates a three-point estimate based on an array of three-tuples.
* Implemented in Java, Go, Node.js, C#, Python and Ruby.
* Deployed as AWS Lambda functions.

## Other services

* [Mailgun](https://mailgun.com/) to send the estimate to a friend.
* [Open Distro for Elasticsearch](https://opendistro.github.io/for-elasticsearch/)
  for logging.
* [Sonarcloud](https://sonarcloud.io/) for static code analysis and QA.
