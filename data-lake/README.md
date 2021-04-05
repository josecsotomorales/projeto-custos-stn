## PySpark Jupyter Docker
E muito conveniente usar o Jupyter Notebook para um ambiente de desenvolvimento interativo com o Spark por meio do PySpark no Jupyter Notebook.

Para criar o container, executa:
```
docker run -it --rm -p 8888:8888 jupyter/pyspark-notebook
```

Para persistir os dados gerados no container, adiciona a flag `-v` ao commando docker.
Exemplo: `/Users/Jose/Workspace/projeto-custos-stn <->“/home/Jose/work`
```
docker run -it --rm -p 8888:8888 -v /Users/Jose/Workspace/projeto-custos-stn:/home/Jose/work jupyter/pyspark-notebook
```

## Acessar ao Jupyter Notebook
Abre a url no browser, o token gerado e disponibilizado nos logs do container:
```
http://localhost:8888/?token=e144d004f6652ae6406a78adf894621e62fdeb1fc57d02e8
```