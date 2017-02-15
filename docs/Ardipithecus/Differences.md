Differences between Ardipithecus and Mastodon
=============================================

Most of the differences between Ardipithecus and Mastodon are aesthetic.
However, a few non-trival differences do occur:

- **Ardipithecus runs slightly behind Mastodon development at all times.**
    This is unavoidable given Ardipithecus is a Mastodon fork, but it is also desirable as it allows us to better document new Mastodon features and ensure their stability.

- **The name `Mastodon` is replaced with `Ardipithecus` for clarity in some locations.**
    These include:

    - Various app JSON files
    - The HTTP `Server` header
    - The name of the Vagrant virtualbox (such that you can run `mastodon.dev` and `ardipithecus.dev` on the same machine)

    However, most internal code retains the `Mastodon` label for consistency and easy compatibility.
