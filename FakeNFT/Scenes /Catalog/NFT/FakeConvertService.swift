import Foundation

final class FakeConvertService: CryptoConverterProtocol {
    var currenciesCount = 8
    
    func convertUSD(to coin: CryptoCoin, amount: Double) -> Double {
        switch coin {
        case .BTC:
            return 0.000036804135018
        case .APE:
            return 0.319488817891374
        case .ADA:
            return 2.631578947368421
        case .DOGE:
            return 13.793103448275862
        case .ETH:
            return 0.000525533021867
        case .SHIB:
            return 115740.740740740740741
        case .SOL:
            return 0.047348484848485
        case .USDT:
            return 1.0
        }
    }
    
    func getCryptocurrencies() -> [Cryptocurrency] {
        [
            Cryptocurrency(name: "Bitcoin", shortname: .BTC),
            Cryptocurrency(name: "ApeCoin", shortname: .APE),
            Cryptocurrency(name: "Cardano", shortname: .ADA),
            Cryptocurrency(name: "Dogecoin", shortname: .DOGE),
            Cryptocurrency(name: "Ethereum", shortname: .ETH),
            Cryptocurrency(name: "Shiba Inu", shortname: .SHIB),
            Cryptocurrency(name: "Solana", shortname: .SOL),
            Cryptocurrency(name: "Tether", shortname: .USDT)
        ]
    }
}
