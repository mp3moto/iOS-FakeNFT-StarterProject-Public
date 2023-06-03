import Foundation

enum CryptoCoin: String {
    case BTC
    case APE
    case ADA
    case DOGE
    case ETH
    case SHIB
    case SOL
    case USDT
}

protocol CryptoConverterProtocol {
    func convertUSD(to: CryptoCoin, amount: Double) -> Double
    func getCryptocurrencies() -> [Cryptocurrency]
}
