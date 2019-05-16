# nodejs-chrome
Docker image to build and test Angular in container.

## Usage

```bash
# run with `privileged` option enabled
docker run --privileged artificerpi/nodejs-chrome ...

# or with customized seccomp security profile (recommended)
docker run --security-opt seccomp:/path/to/chrome.json artificerpi/nodejs-chrome ...
```


A sample to work with drone.io

```yaml
---
kind: pipeline
name: default


steps:
- name: build
  image: node
  commands:
    - npm install
    - ./node_modules/.bin/ng build

- name: test
  image: artificerpi/nodejs-chrome
  commands:
    - ./node_modules/.bin/ng e2e
    - ./node_modules/.bin/ng test --browsers=ChromeHeadless --watch=false
```

* Use in angular project

It's working with `ng e2e` tests, but there are some problem with karama.
One workaround is to run chrome in headless mode.

```bash
ng test --browsers=ChromeHeadless --watch=false
```

## Reference
* https://developers.google.com/web/updates/2017/04/headless-chrome
* https://github.com/jessfraz/dockerfiles/issues/65