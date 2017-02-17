Differences between Ardipithecus and Mastodon
=============================================

- **Ardipithecus runs slightly behind Mastodon development at all times.**
    This is unavoidable given Ardipithecus is a Mastodon fork, but it is also desirable as it allows us to better document new Mastodon features and ensure their stability.

- **The name `Mastodon` is replaced with `Ardipithecus` for clarity in some locations.**
    These include:

    - Various app JSON files
    - The HTTP `Server` header
    - The name of the Vagrant virtualbox (such that you can run `mastodon.dev` and `ardipithecus.dev` on the same machine)

    However, most internal code retains the `Mastodon` label for consistency and easy compatibility.

- **Ardipithecus adds additional informative views.**
    Mastodon has a portal that looks something like this:

    ```
    about#index
    | - about#more
    | - about#terms
    | - home#index
    ```

    Ardipithecus, on the other hand, defaults to something like this:

    ```
    portal#index
    | - home#index
    | - about#index
      | - about#mission
      | - about#principles
      | - about#terms
      | - about#privacy
    ```

    You can customize which about files are available on your instance by editing `/config/routes.rb`, `/app/controllers/about_controller.rb` and `/app/views/layouts/about.html.haml`, and providing the necessary views in `/app/views/about/`.
    (This is actually a fairly trivial process.)

- **Ardipithecus expects instances to provide their own about pages.**
    Mastodon stores "about" information in the server settings, and then accesses these to produce `about#index` and `about#more`.
    This is a questionable policy as it prevents this information from ever being localized.
    Ardipithecus provides minimal defaults in `/app/views/about` but expects instances to fill out this information themselves.

    The `site_description` and `site_extended_description` properties of `Setting` are ignored by Ardipithecus.

- **Ardipithecus has different localization requirements from Mastodon.**
    The `config/locales/ardipithecus.*.yml` files provide additional terms in need of localization that are not included in the Mastodon localization files.
    Conversely, not all of the terms defined in the Mastodon localization files are used.
    (However, these are not removed.)

- **Ardipithecus has vastly different layout and styling for about pages.**
    All of the styling is different.
    All of it.
    (And if not, it soon will be.)

- **Ardipithecus doesn't ship with a frontend.**
    Ardipithecus is only a backend.
    Frontends should be placed in an assets folder and specified in `.env.production`
    You can download a copy of the default Mastodon frontend [here](https://github.com/marrus-sh/mastodon-front)
