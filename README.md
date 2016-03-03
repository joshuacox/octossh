# octossh
Simple SSH container for Octohost

# usage

```
docker pull joshuacox/octossh
```

```
docker run -it -e KEY_URL=https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/keys joshuacox/octossh
```

where the `KEY_URL` represents an url where the container can download a list pubs that can be put into the `.ssh/authorized_keys` file
