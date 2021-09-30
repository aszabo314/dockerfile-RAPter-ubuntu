https://github.com/amonszpart/RAPter

`3000s + 12GB`

docker:
```
docker build -t rapterubuntu .
docker run -it -v C:\proj\dockerfile-RAPter-ubuntu\share:/things rapterubuntu
```

bash:
```bash
# copy filename "cloud.ply" into share folder
cd /things && python rapter.py -s 0.025
```