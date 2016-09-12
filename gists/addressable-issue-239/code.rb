require "addressable/uri"

URL = "http://AcinusFallumTrompetumNullunCreditumVisumEstAtCuadLongumEtCefallumEst.com"
p Addressable::URI.heuristic_parse(URL).normalized_host
p Addressable::URI.parse(URL).normalized_host
