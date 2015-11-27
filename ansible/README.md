Get docker droplet ins Digital Ocean
------------------------------------

    http -a 'TOKEN' https://api.digitalocean.com/v2/images? type==application page==2

Response :

     {
          "created_at": "2015-11-20T18:52:28Z",
          "distribution": "Ubuntu",
          "id": 14486461,
          "min_disk_size": 20,
          "name": "Docker 1.9.1 on 14.04",
          "public": true,
          "regions": [
              "nyc1",
              "sfo1",
              "nyc2",
              "ams2",
              "sgp1",
              "lon1",
              "nyc3",
              "ams3",
              "fra1",
              "tor1"
          ],
          "slug": "docker",
          "type": "snapshot"
      }

Get Digital Ocean regions
------------------------------------

    http -a 'TOKEN' https://api.digitalocean.com/v2/regions?
