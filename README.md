# Santiago's Dockerfiles

This project contains several Dockerfiles used by my different projects. In particular:

- **cpp-dev**: A full-featured Dockerfile used for C++ development.
- **tum-latex**: The LaTeX template used for TUM documents, such as dissertations.

## Using the images

I have all of these images hosted in my [Dockerhub](https://hub.docker.com/repositories/santiagonar1)
`santiagonar1`. Therefore, if you do not want to build them manually, simply pull the image:

```sh
make pull-<image-name>
```

For example:

```sh
make pull-cpp-dev
```

You could then start a containe and mount your current directory with:

```sh
docker run --rm -it -v .:/my-project -w /my-project santiagonar1/<image-name> bash
```

## Building images

For all images, except `tum-latex`, simply execute:

```sh
make <image-name>
```

For example:

```sh
make cpp-dev
```

### Building `tum-latex`

The `tum-latex` image requires access to the internal [TUM Templates](https://gitlab.lrz.de/latex4ei/tum-templates)
project hosted by the [LRZ GitLab](https://gitlab.lrz.de/), which is not publicly available.
This in turns mean that you need to:

1. Create a [Personal Access Token](https://docs.gitlab.com/user/profile/personal_access_tokens/) with `read_repository` and `read_api` scopes.
2. Execute `GITLAB_TOKEN=<your token> make tum-latex`.
