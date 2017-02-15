Ardipithecus | Mastodon
=======================

<!--

Travis support for Ardipithecus not here yet!!

[![Build Status](http://img.shields.io/travis/tootsuite/mastodon.svg)][travis]
[![Code Climate](https://img.shields.io/codeclimate/github/tootsuite/mastodon.svg)][code_climate]

[travis]: https://travis-ci.org/tootsuite/mastodon
[code_climate]: https://codeclimate.com/github/tootsuite/mastodon

-->

**Ardipithecus** is a fork of **[Mastodon](https://github.com/tootsuite/mastodon)**, a GNU Social-compatible microblogging server.
It aims to maintain the Mastodon backend and API while presenting a modified user experience.
Anyone can run Ardipithecus and participate in the social network seamlessly.

Because it is a fork with nontrivial modifications, Ardipithecus will run slightly behind Mastodon development at all times.
The philosophy of Ardipithecus is to provide stable, well-documented updates at regular intevals, which means occasionally introducing a delay before incorporating upstream changes.

Ardipithecus uses the Mastodon backend, so the best way to encourage the introduction of new features is to [support the development of Mastodon on Patreon][patreon].

[patreon]: https://www.patreon.com/user?u=619786

## Resources

- [Differences between Ardipithecus and Mastodon](docs/Ardipithecus/Differences.md)
- [List of Mastodon instances](docs/Using-Mastodon/List-of-Mastodon-instances.md)
- [Use this tool to find Twitter friends on Mastodon](https://mastodon-bridge.herokuapp.com)
- [API overview](docs/Using-the-API/API.md)
- [Frequently Asked Questions](docs/Using-Mastodon/FAQ.md)
- [List of apps](docs/Using-Mastodon/Apps.md)

## Features

- **Fully interoperable with GNU social and any OStatus platform**
  Whatever implements Atom feeds, ActivityStreams, Salmon, PubSubHubbub and Webfinger is part of the network
- **Real-time timeline updates**
  See the updates of people you're following appear in real-time in the UI via WebSockets
- **Federated thread resolving**
  If someone you follow replies to a user unknown to the server, the server fetches the full thread so you can view it without leaving the UI
- **Media attachments like images and WebM**
  Upload and view images and WebM videos attached to the updates
- **OAuth2 and a straightforward REST API**
  Mastodon acts as an OAuth2 provider so 3rd party apps can use the API, which is RESTful and simple
- **Background processing for long-running tasks**
  Mastodon tries to be as fast and responsive as possible, so all long-running tasks that can be delegated to background processing, are
- **Deployable via Docker**
  You don't need to mess with dependencies and configuration if you want to try Mastodon, if you have Docker and Docker Compose the deployment is extremely easy

## Configuration

- `LOCAL_DOMAIN` should be the domain/hostname of your instance. This is **absolutely required** as it is used for generating unique IDs for everything federation-related
- `LOCAL_HTTPS` set it to `true` if HTTPS works on your website. This is used to generate canonical URLs, which is also important when generating and parsing federation-related IDs

Consult the example configuration file, `.env.production.sample` for the full list. Among other things you need to set details for the SMTP server you are going to use.

## Requirements

- Ruby
- Node.js
- PostgreSQL
- Redis
- Nginx

## Running with Docker and Docker-Compose

The project now includes a `Dockerfile` and a `docker-compose.yml`. You need to turn `.env.production.sample` into `.env.production` with all the variables set before you can:

    docker-compose build

And finally

    docker-compose up -d

As usual, the first thing you would need to do would be to run migrations:

    docker-compose run --rm web rails db:migrate

And since the instance running in the container will be running in production mode, you need to pre-compile assets:

    docker-compose run --rm web rails assets:precompile

The container has two volumes, for the assets and for user uploads. The default docker-compose.yml maps them to the repository's `public/assets` and `public/system` directories, you may wish to put them somewhere else. Likewise, the PostgreSQL and Redis images have data containers that you may wish to map somewhere where you know how to find them and back them up.

**Note**: The `--rm` option for docker-compose will remove the container that is created to run a one-off command after it completes. As data is stored in volumes it is not affected by that container clean-up.

### Tasks

- `rake mastodon:media:clear` removes uploads that have not been attached to any status after a while, you would want to run this from a periodic cronjob
- `rake mastodon:push:clear` unsubscribes from PuSH notifications for remote users that have no local followers. You may not want to actually do that, to keep a fuller footprint of the fediverse or in case your users will soon re-follow
- `rake mastodon:push:refresh` re-subscribes PuSH for expiring remote users, this should be run periodically from a cronjob and quite often as the expiration time depends on the particular hub of the remote user
- `rake mastodon:feeds:clear_all` removes all timelines, which forces them to be re-built on the fly next time a user tries to fetch their home/mentions timeline. Only for troubleshooting
- `rake mastodon:feeds:clear` removes timelines of users who haven't signed in lately, which allows to save RAM and improve message distribution. This is required to be run periodically so that when they login again the regeneration process will trigger

Running any of these tasks via docker-compose would look like this:

    docker-compose run --rm web rake mastodon:media:clear

### Updating

This approach makes updating to the latest version a real breeze.

    git pull

To pull down the updates, re-run

    docker-compose build

And finally,

    docker-compose up -d

Which will re-create the updated containers, leaving databases and data as is. Depending on what files have been updated, you might need to re-run migrations and asset compilation.

## Deployment without Docker

Docker is great for quickly trying out software, but it has its drawbacks too. If you prefer to run Mastodon without using Docker, refer to the [production guide](docs/Running-Mastodon/Production-guide.md) for examples, configuration and instructions.

## Deployment on Heroku (experimental)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Mastodon can theoretically run indefinitely on a free [Heroku](https://heroku.com) app. [You can view a guide for deployment on Heroku here.](docs/Running-Mastodon/Heroku-guide.md)

## Development with Vagrant

A quick way to get a development environment up and running is with Vagrant. You will need recent versions of [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed.

[You can find the guide for setting up a Vagrant development environment here.](docs/Running-Mastodon/Vagrant-guide.md)

## Contributing

You can open issues for bugs you've found or features you think are missing. You can also submit pull requests to this repository. This section may be updated with more details in the future.

**IRC channel**: #mastodon on irc.freenode.net

## Extra credits

- The [Emoji One](https://github.com/Ranks/emojione) pack has been used for the emojis
- The error page image courtesy of [Dopatwo](https://www.youtube.com/user/dopatwo)

![Mastodon error image](https://mastodon.social/oops.png)
