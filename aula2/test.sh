#!/bin/bash

mkdir -p data

echo "--------------------------------------------------------------------------------"
echo "1. Corrigir o switch -d para não somente baixar o arquivo compactado, mas também descompactá-lo no mesmo diretório que se encontra."
echo "  - Importante verificar se o arquivo já não foi descompactado;"
echo "  - O descompactador dtrx (disponível no linux e mac) pode ser utilizado para essa tarefa."
echo
echo "  Resposta: "
echo "          - Optamos por utilizar o bzip2, ao invés do dtrx, porque vem instalado por padrão no ubuntu"
echo "          - Decidimos alterar o parâmetro -d para outra funcionalidade. Como resultado, o script sempre espera o caminho onde os CSVs estão armazenados (ou serão armazenados caso não existam)"
echo "  Como executar:"
echo "          ./flight-delays.sh data"
echo "  Resultado:"
./flight-delays.sh data | head
echo "..."
echo "--------------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------"
echo "2. Extrair número de atrasos, recebendo como parâmetro, o ano de referência, e.g.: ./flight-delays -n 2006 deve listar o número de vôos com atraso em 2006."
echo "  Resposta: "
echo "          - Decidimos alterar o parâmetro -n para -y por ser mais sugestivo."
echo "          - Decidimos adicionar o parâmetro -d para indicar apenas voos com atraso."
echo "          - Decidimos adicionar o parâmetro -c para contar os resultados da etapa de filtragem anterior."
echo "  Como executar:"
echo "          ./flight-delays.sh -d -y 2006 -c data"
echo "  Resultado:"
./flight-delays.sh -d -y 2006 -c data
echo "--------------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------"
echo "3. Mostrar lista de companhias aéreas que sofreram atraso, recebendo como parâmetro o ano de referência"
echo "  Resposta: "
echo "          - Decidimos adicionar o parâmetro -X para retornar o nome das empresas presentes nas etapas de filtragem anteriores."
echo "  Como executar:"
echo "          ./flight-delays.sh -d -y 2006 -X data"
echo "  Resultado:"
./flight-delays.sh -d -y 2006 -X data
echo "--------------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------"
echo "4. Mostrar a lista de Aeroportos com atrasos, recevendo como parâmetro o ano de referência"
echo "  Resposta: "
echo "          - Decidimos adicionar o parâmetro -A para retornar o nome dos aeroportos presentes nas etapas de filtragem anteriores."
echo "  Como executar:"
echo "          ./flight-delays.sh -d -y 2006 -A data"
echo "  Resultado:"
./flight-delays.sh -d -y 2006 -A data
echo "--------------------------------------------------------------------------------"
