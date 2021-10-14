#!/usr/bin/env bash

echo "Start..."

# Open Banking Fase 2
VERSION=$(grep 'version:' source/swagger/parts/_accounts_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_accounts_apis_part.yml --outfile source/swaggers/accounts/doc/${VERSION}.json --type=json
VERSION=$(grep 'version:' source/swagger/parts/_consents_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_consents_apis_part.yml --outfile source/swaggers/consents/doc/${VERSION}.json --type=json
VERSION=$(grep 'version:' source/swagger/parts/_credit_cards_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_credit_cards_apis_part.yml --outfile source/swaggers/credit_cards/doc/${VERSION}.json --type=json
VERSION=$(grep 'version:' source/swagger/parts/_customers_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_customers_apis_part.yml --outfile source/swaggers/customers/doc/${VERSION}.json --type=json
VERSION=$(grep 'version:' source/swagger/parts/_financings_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_financings_apis_part.yml --outfile source/swaggers/financings/doc/${VERSION}.json --type=json
VERSION=$(grep 'version:' source/swagger/parts/_invoice_financings_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_invoice_financings_apis_part.yml --outfile source/swaggers/invoice_financings/doc/${VERSION}.json --type=json
VERSION=$(grep 'version:' source/swagger/parts/_loans_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_loans_apis_part.yml --outfile source/swaggers/loans/doc/${VERSION}.json --type=json
VERSION=$(grep 'version:' source/swagger/parts/_resources_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_resources_apis_part.yml --outfile source/swaggers/resources/doc/${VERSION}.json --type=json
VERSION=$(grep 'version:' source/swagger/parts/_unarranged_accounts_overdraft_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_unarranged_accounts_overdraft_apis_part.yml --outfile source/swaggers/unarranged_accounts_overdraft/doc/${VERSION}.json --type=json


# Open Banking Fase 3
VERSION=$(grep 'version:' source/swagger/parts/_payments_apis_part.yml | tail -n1 | awk '{ print $2}')
swagger-cli bundle source/swagger/parts/_payments_apis_part.yml --outfile source/swaggers/payments/doc/${VERSION}.json --type=json


# Generate dictionary
##sh ./build-dictionary.sh

# Open Banking Fase 2
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/accounts/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/consents/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/credit_cards/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/customers/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/financings/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/invoice_financings/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/loans/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/resources/doc/*.json
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/unarranged_accounts_overdraft/doc/*.json

# Open Banking Fase 3
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/swaggers/payments/doc/*.json

# Validations
# Open Banking Fase 2
swagger-cli validate source/swaggers/accounts/doc/*.json
swagger-cli validate source/swaggers/consents/doc/*.json
swagger-cli validate source/swaggers/credit_cards/doc/*.json
swagger-cli validate source/swaggers/customers/doc/*.json
swagger-cli validate source/swaggers/financings/doc/*.json
swagger-cli validate source/swaggers/invoice_financings/doc/*.json
swagger-cli validate source/swaggers/loans/doc/*.json
swagger-cli validate source/swaggers/resources/doc/*.json
swagger-cli validate source/swaggers/unarranged_accounts_overdraft/doc/*.json
spectral lint source/swaggers/accounts/doc/*.json
spectral lint source/swaggers/consents/doc/*.json
spectral lint source/swaggers/credit_cards/doc/*.json
spectral lint source/swaggers/customers/doc/*.json
spectral lint source/swaggers/financings/doc/*.json
spectral lint source/swaggers/invoice_financings/doc/*.json
spectral lint source/swaggers/loans/doc/*.json
spectral lint source/swaggers/resources/doc/*.json
spectral lint source/swaggers/unarranged_accounts_overdraft/doc/*.json
# Open Banking Fase 3
swagger-cli validate source/swaggers/payments/doc/*.json
spectral lint source/swaggers/payments/doc/*.json

echo "...Finish"