# Roblox Fashion Showroom

Este repositório contém a base de um projeto Roblox Studio para um showroom de moda com:
- área central de exposição
- pedestais com avatares/outfits
- provador de roupas
- área especial de Korblox & Headless
- integração com RemoteEvents/RemoteFunctions
- loja e compras seguras no servidor
- suporte a favoritos e persistência local

## Estrutura recomendada no Roblox Studio

Crie os seguintes diretórios/objetos na árvore do projeto:

- `ReplicatedStorage`
  - `Modules`
    - `Config`
    - `OutfitCatalog`
- `ServerScriptService`
  - `MapBuilder`
  - `OutfitService`
  - `ShopService`
- `StarterPlayer`
  - `StarterPlayerScripts`
    - `ShowroomClient`
    - `AvatarPreview`

## Como instalar

1. Abra o Roblox Studio.
2. Crie um novo Place.
3. Dentro do Explorer, crie as pastas e scripts conforme a estrutura acima.
4. Copie o conteúdo de cada arquivo `.lua` deste repositório para os respectivos scripts no Studio.
5. Ajuste IDs reais de itens, roupas e produtos do catálogo nos arquivos de configuração.
6. Pressione Play para testar.

## Importante sobre compras e itens

- O Roblox não permite simular compra de itens como se fossem comprados.
- O código abaixo usa `MarketplaceService:PromptProductPurchase`/`PromptPurchase` somente quando o jogador clica explicitamente em "Comprar".
- A prévia e o try-on são sempre temporários e não concedem propriedade permanente.
- O item real só muda de estado de posse quando o jogador conclui uma compra oficial do Roblox.

## Limitações da plataforma

Algumas funções do design solicitado podem ter limitações reais:
- não é possível alterar permanentemente a aparência do avatar do jogador sem um item válido e aquisição real do catálogo
- não é possível forçar "equipping" de itens que não são do catálogo do usuário sem a API oficial do Roblox
- as imagens de referência não podem ser reproduzidas pixel a pixel, mas a identidade visual e a estrutura funcional podem ser adaptadas para ficar bem próximas

## Scripts principais

- `MapBuilder.lua`: cria o ambiente visual estilo showroom
- `OutfitService.lua`: gerencia o catálogo, favoritos, prévia e remote calls
- `ShopService.lua`: compra de itens e validação no servidor
- `ShowroomClient.lua`: UI de menu, categorias, cartelas e botão de try-on
- `AvatarPreview.lua`: prévias e alteração visual local em personagem/mannequim

## Dicas de expansão

- Adicione mais outfits no `OutfitCatalog.lua`
- Troque o visual do mapa e da iluminação conforme a marca/estilo desejado
- Use `DataStoreService` para persistir favoritos em produção
- Conecte itens reais de catálogo para uso em produçao final

## Observação de segurança

Os preços, nomes, IDs e permissões nunca devem ser confiados diretamente do cliente. Sempre valide no servidor e mantenha o catálogo centralizado.

