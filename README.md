Original file from: https://gist.github.com/zinovyev/0ad6bd54ac5a9f7b709607a8151a0334

# English

When editing debtap-mod I realized that it shouldn't be too difficult to do something like that for .rpm files and found the top page script already doing most of the hard work, so I made some changes, including checking dependencies using namcap and adapted the interface in Yad that I had already made for debtap-mod.

So here we have a .rpm converter/installer for systems using the Pamac package manager.

Whenever possible use packages made for your distribution, but if you don't have this option, check if the program is available in .deb and install using debtap-mod, if you can't find a .deb, use a .rpm with use of this design, it is less elaborate, but still has good effectiveness.


# Português

Ao editar o debtap-mod percebi que não deveria ser muito difícil fazer algo parecido para arquivos .rpm e encontrei o script do início da página que já fazia quase todo o trabalho difícil, então fiz algumas alterações, inclui a verificação de dependências utilizando o namcap e adaptei a interface em Yad que já havia feito para o debtap-mod.

Então aqui temos um conversor/instalador de .rpm para sistemas que utilizam o gerenciador de pacotes Pamac.

Sempre que possível utilize pacotes feitos para a sua distribuição, mas se não tem essa opção, verifique se o programa está disponível em .deb e instale utilizando o debtap-mod, se não for possível encontrar um .deb, utilize um .rpm com o uso desse projeto, ele é menos elaborado, mas ainda possui uma boa eficácia.
