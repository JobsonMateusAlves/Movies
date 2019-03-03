# Movies

## Apresentação

O projeto consiste em um aplicativo que possui a opção de buscar filmes, além disso é possível visualizar informações desse filme, como o nome, a sinopse, uma imagem do filme e uma lista de videos, sendo possível assistir a esses videos abrindo-os no youtube, possibilita também que o usuário marque filmes como favoritos e possa acessar uma lista com esses filmes marcados.


## Arquitetura do Projeto
- Arquitetura utilizada: MVVM.
- Esta arquitetura foi utilizada pois possibilita uma abstração de informações para a ViewController, enviando para ela, apenas as informações que serão apresentadas na tela já prontas para serem exibidas. Nesta arquitetura a View não se comunica diretamente com os Models, está comunicação é feita somente através do ViewModel. 
  - Models: São os modelos do que estará armazenado no banco de dados.
  - ViewModels: São classes responsáveis por acessar o banco de dados, pegar as informações necessárias, tratá-las e enviá-las para a ViewController prontas para serem exibidas.
  - View: Classe responsável por definir a estrutura que o usuário vê na tela.

## Bibliotecas de Terceiros Utilizadas

Neste projeto foram utilizadas as seguintes bibliotecas:
- Alamofire
- ObjectMapper
- AlamofireObjectMapper
- SwiftGen
- RealmSwift
- Reusable
- Kingfisher
- SwiftMessages
- SpringIndicator
- StatefulViewController

## Melhorias

- Adicionaria um Player para que o usuario pudesse assistir aos videos dentro do próprio aplicativo
- Melhoraria o design
- Adicionaria uma tela com a opção de busca por filtro, que é uma opção oferecida pela API utilizada(movie Database API).

## Requisitos

Todos os requisitos foram cumpridos.

## Imagens

A seguir são apresentadas algumas imagens das telas do aplicativo.

![captura de tela 2019-03-03 as 01 50 04](https://user-images.githubusercontent.com/44685592/53696245-e5731980-3da3-11e9-9e80-8411ace87815.png)

![captura de tela 2019-03-03 as 01 51 54](https://user-images.githubusercontent.com/44685592/53696287-3b47c180-3da4-11e9-8bd9-5b9638632741.png)

![captura de tela 2019-03-03 as 10 16 32](https://user-images.githubusercontent.com/44685592/53696283-33881d00-3da4-11e9-9d90-6a8cc8642d4a.png)
