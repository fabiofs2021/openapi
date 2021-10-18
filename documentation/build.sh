#!/usr/bin/env bash

echo "Start..."

# Open Banking Fase 2
VERSION=$(grep 'version:' source/swagger/parts/_accounts_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_accounts_apis_part.yml --outfile build/swagger/accounts/doc/${VERSION}.json --type=json && cp build/swagger/accounts/doc/${VERSION}.json versions/swagger/accounts/doc/${VERSION}.json 
VERSION=$(grep 'version:' source/swagger/parts/_consents_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_consents_apis_part.yml --outfile build/swagger/consents/doc/${VERSION}.json --type=json && cp build/swagger/consents/doc/${VERSION}.json versions/swagger/consents/doc/${VERSION}.json
VERSION=$(grep 'version:' source/swagger/parts/_credit_cards_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_credit_cards_apis_part.yml --outfile build/swagger/credit_cards/doc/${VERSION}.json --type=json && cp build/swagger/credit_cards/doc/${VERSION}.json versions/swagger/credit_cards/doc/${VERSION}.json
VERSION=$(grep 'version:' source/swagger/parts/_customers_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_customers_apis_part.yml --outfile build/swagger/customers/doc/${VERSION}.json --type=json && cp build/swagger/customers/doc/${VERSION}.json versions/swagger/customers/doc/${VERSION}.json
VERSION=$(grep 'version:' source/swagger/parts/_financings_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_financings_apis_part.yml --outfile build/swagger/financings/doc/${VERSION}.json --type=json && cp build/swagger/financings/doc/${VERSION}.json versions/swagger/financings/doc/${VERSION}.json
VERSION=$(grep 'version:' source/swagger/parts/_invoice_financings_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_invoice_financings_apis_part.yml --outfile build/swagger/invoice_financings/doc/${VERSION}.json --type=json && cp build/swagger/invoice_financings/doc/${VERSION}.json versions/swagger/invoice_financings/doc/${VERSION}.json
VERSION=$(grep 'version:' source/swagger/parts/_loans_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_loans_apis_part.yml --outfile build/swagger/loans/doc/${VERSION}.json --type=json && cp build/swagger/loans/doc/${VERSION}.json versions/swagger/loans/doc/${VERSION}.json
VERSION=$(grep 'version:' source/swagger/parts/_resources_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_resources_apis_part.yml --outfile build/swagger/resources/doc/${VERSION}.json --type=json && cp build/swagger/resources/doc/${VERSION}.json versions/swagger/resources/doc/${VERSION}.json
VERSION=$(grep 'version:' source/swagger/parts/_unarranged_accounts_overdraft_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_unarranged_accounts_overdraft_apis_part.yml --outfile build/swagger/unarranged_accounts_overdraft/doc/${VERSION}.json --type=json && cp build/swagger/unarranged_accounts_overdraft/doc/${VERSION}.json versions/swagger/unarranged_accounts_overdraft/doc/${VERSION}.json


# Copiando os arquivos para a pasta versions:
cp build/swagger/accounts/doc/*.json


# Open Banking Fase 3
VERSION=$(grep 'version:' source/swagger/parts/_payments_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_payments_apis_part.yml --outfile build/swagger/payments/doc/${VERSION}.json --type=json


# Generate dictionary
##sh ./build-dictionary.sh

# Open Banking Fase 2
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/accounts/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/consents/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/credit_cards/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/customers/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/financings/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/invoice_financings/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/loans/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/resources/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/unarranged_accounts_overdraft/doc/*.json

# Open Banking Fase 3
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' build/swagger/payments/doc/*.json

# Validations
# Open Banking Fase 2
swagger-cli validate build/swagger/accounts/doc/*.json
swagger-cli validate build/swagger/consents/doc/*.json
swagger-cli validate build/swagger/credit_cards/doc/*.json
swagger-cli validate build/swagger/customers/doc/*.json
swagger-cli validate build/swagger/financings/doc/*.json
swagger-cli validate build/swagger/invoice_financings/doc/*.json
swagger-cli validate build/swagger/loans/doc/*.json
swagger-cli validate build/swagger/resources/doc/*.json
swagger-cli validate build/swagger/unarranged_accounts_overdraft/doc/*.json
spectral lint build/swagger/accounts/doc/*.json
spectral lint build/swagger/consents/doc/*.json
spectral lint build/swagger/credit_cards/doc/*.json
spectral lint build/swagger/customers/doc/*.json
spectral lint build/swagger/financings/doc/*.json
spectral lint build/swagger/invoice_financings/doc/*.json
spectral lint build/swagger/loans/doc/*.json
spectral lint build/swagger/resources/doc/*.json
spectral lint build/swagger/unarranged_accounts_overdraft/doc/*.json
# Open Banking Fase 3
swagger-cli validate build/swagger/payments/doc/*.json
spectral lint build/swagger/payments/doc/*.json

echo "...Finish"