# flutter_parse

Projeto de estudo do framework Flutter.

O objetivo principal é a criação de um App que colete informações de localidade e uma foto capturada no local, e depois exibir em uma listagem de todos os pontos registrados.

O backend escolhido foi o ParseServer, que funciona como Baas (Backend as a service), hospedado pela Back4App.

## Executando projeto

Antes de executar, você precisa preencher as chaves de acesso ao [Back4App](www.back4app.com).

Renomei o arquivo ```exemple.env``` para ```.env``` e adicione o ID do App, Client Key e a url do seu aplicativo Parse. Você encontra essas chaves no Back4App em ```Server Settings > Core Settings > Settings and find your keys``` .

Depois é só executar o ```flutter pub get``` e ```flutter run android```

## Prints das telas

Separados por versões.

### v1

- Listagem de focos:
![Imgur](https://i.imgur.com/CAO4IF6.png)

- Adicionar Foco:
![Imgur](https://i.imgur.com/FjTY3DS.png)

- Após tirar foto
![Imgur](https://i.imgur.com/DNPlL9q.png)

- Mensagem de confirmação
![Imgur](https://i.imgur.com/1cwoTut.png)
