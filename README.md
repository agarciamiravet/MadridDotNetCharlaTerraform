# MadridDotNetCharlaTerraform
Material de la charla dada en MadriDotnet llamada **Desplegar en Azure en Terraform** el 21 de octubre de 2019

Cualquier pregunta contactar conmigo a través de Twitter @alexmiravet

# Objetivo

El objetivo es deplegar esta infraestructura:

![](https://i.ibb.co/0B9vw7h/Arquitecture.png)

# Mini Posts

Parte de lo explicado en la charla, ha sido anteriormente creado como posts en mi página [recetasdevops.com](https://www.recetasdevops.com)

A continuación detallo los posts realizados:

[Primeros pasos provisionando infraestructura en Azure con Terraform](https://recetasdevops.com/primeros-pasos-provisionando-infraestructura-en-azure-con-terraform/)

[ Terraform 0.12 – Crear un Azure Web App](https://recetasdevops.com/terraform-0-12-crear-un-azure-web-app/)

[ Tu primer módulo de Terraform](https://recetasdevops.com/tu-primer-modulo-de-terraform/)

[ Tus tests de Azure con InSpec](https://recetasdevops.com/tus-tests-de-azure-con-inspec/)

[ Migra tu infraestructura actual de Azure a Terraform con py-az2tf](https://recetasdevops.com/migra-tu-infraestructura-actual-de-azure-a-terraform-con-py-az2tf/)

Bonus

[Desplegar con Terraform desde una release de Azure DevOps usando como state Terraform cloud](https://recetasdevops.com/desplegar-con-terraform-desde-una-release-de-azure-devops-usando-como-state-terraform-cloud/)

[ Ejecuta tu código de terraform de Github en remoto con Terraform Cloud](https://recetasdevops.com/ejecuta-tu-codigo-de-terraform-de-github-en-remoto-con-terraform-cloud/)

[Instalar Terraform en Windows](https://recetasdevops.com/instalar-terraform-en-windows/)

[Instalar Terraform en Linux Ubuntu](https://recetasdevops.com/instalar-terraform-en-linux-ubuntu/)

# Código fuente 

** 01-Forma más simple**
Dentro del repositorio, en https://github.com/agarciamiravet/MadridDotNetCharlaTerraform/tree/master/src/01-SimpleForm podeís encontrar el código para desplegar nuestra infraestrura mencionada arriba en **Objetivo** usando Terraform de la forma más sencilla. Es decir usando un único fichero .tf sin usar módulos ni nada más.

**02-Usando módulos**
Dentro del repositorio, en https://github.com/agarciamiravet/MadridDotNetCharlaTerraform/tree/master/src/02-WithModules encontareís como desplegar la arquitectura de ejemplo, pero esta vez haciendo uso de módulos en local. Estos módulos estan ubicados en la carpeta Modules en:

https://github.com/agarciamiravet/MadridDotNetCharlaTerraform/tree/master/src/02-WithModules/Modules

**03-Usando múltiples directorios y módulos en remoto**
Dentro del repositorio, en https://github.com/agarciamiravet/MadridDotNetCharlaTerraform/tree/master/src/03-MultiFolderAndRemoteModules podeís encontrar una tercera forma para desplegar la infraestructura.

En este caso separamos cada uno de los componentes de nuestra infraestructura en carpetas, para asi tener diferentes ficheros de estados y poder desplegar independientemente nuestra infraestrutura. 

Aparte, en vez de hacer uso de módulos en local, en este ejemplo podeís ver 
el uso de módulos úbicados en remoto. En mi caso alojados en repositorios de GitHub. La ruta de estos repositorios son:

[https://github.com/recetasdevops/CharlaMDDatabaseModule](https://github.com/recetasdevops/CharlaMDDatabaseModule)

[https://github.com/recetasdevops/CharlaMDWebAppModule](https://github.com/recetasdevops/CharlaMDWebAppModule)

Asimismo dentro de este ejemplo podeís encontrar algunos tests realizados con Inspec.  La ubicación de estos tests es:
[https://github.com/agarciamiravet/MadridDotNetCharlaTerraform/tree/master/src/03-MultiFolderAndRemoteModules/VerificationTests](https://github.com/agarciamiravet/MadridDotNetCharlaTerraform/tree/master/src/03-MultiFolderAndRemoteModules/VerificationTests)
