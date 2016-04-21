//
//	SwiftDate, an handy tool to manage date and timezones in swift
//	Created by:				Daniele Margutti
//	Main contributors:		Jeroen Houtzager
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable type_name

public enum LocaleName: String {

    public var description: String {
        return self.rawValue
    }

    public var locale: NSLocale {
        switch self {
        case .Current:
            return NSLocale.currentLocale()
        case .System:
            return NSLocale.systemLocale()
        default:
            return NSLocale(localeIdentifier: self.rawValue)
        }
    }

    case Current = "Current"
    case System = "System"

    case Afrikaans = "af"
    case AfrikaansNamibia = "af_NA"
    case AfrikaansSouthAfrica = "af_ZA"
    case Aghem = "agq"
    case AghemCameroon = "agq_CM"
    case Akan = "ak"
    case AkanGhana = "ak_GH"
    case Albanian = "sq"
    case AlbanianAlbania = "sq_AL"
    case AlbanianKosovo = "sq_XK"
    case AlbanianMacedonia = "sq_MK"
    case Amharic = "am"
    case AmharicEthiopia = "am_ET"
    case Arabic = "ar"
    case ArabicAlgeria = "ar_DZ"
    case ArabicBahrain = "ar_BH"
    case ArabicChad = "ar_TD"
    case ArabicComoros = "ar_KM"
    case ArabicDjibouti = "ar_DJ"
    case ArabicEgypt = "ar_EG"
    case ArabicEritrea = "ar_ER"
    case ArabicIraq = "ar_IQ"
    case ArabicIsrael = "ar_IL"
    case ArabicJordan = "ar_JO"
    case ArabicKuwait = "ar_KW"
    case ArabicLebanon = "ar_LB"
    case ArabicLibya = "ar_LY"
    case ArabicMauritania = "ar_MR"
    case ArabicMorocco = "ar_MA"
    case ArabicOman = "ar_OM"
    case ArabicPalestinianTerritories = "ar_PS"
    case ArabicQatar = "ar_QA"
    case ArabicSaudiArabia = "ar_SA"
    case ArabicSomalia = "ar_SO"
    case ArabicSouthSudan = "ar_SS"
    case ArabicSudan = "ar_SD"
    case ArabicSyria = "ar_SY"
    case ArabicTunisia = "ar_TN"
    case ArabicUnitedArabEmirates = "ar_AE"
    case ArabicWesternSahara = "ar_EH"
    case ArabicWorld = "ar_001"
    case ArabicYemen = "ar_YE"
    case Armenian = "hy"
    case ArmenianArmenia = "hy_AM"
    case Assamese = "as"
    case AssameseIndia = "as_IN"
    case Asu = "asa"
    case AsuTanzania = "asa_TZ"
    case Azerbaijani = "az_Latn"
    case AzerbaijaniAzerbaijan = "az_Latn_AZ"
    case AzerbaijaniCyrillic = "az_Cyrl"
    case AzerbaijaniCyrillicAzerbaijan = "az_Cyrl_AZ"
    case Bafia = "ksf"
    case BafiaCameroon = "ksf_CM"
    case Bambara = "bm_Latn"
    case BambaraMali = "bm_Latn_ML"
    case Basaa = "bas"
    case BasaaCameroon = "bas_CM"
    case Basque = "eu"
    case BasqueSpain = "eu_ES"
    case Belarusian = "be"
    case BelarusianBelarus = "be_BY"
    case Bemba = "bem"
    case BembaZambia = "bem_ZM"
    case Bena = "bez"
    case BenaTanzania = "bez_TZ"
    case Bengali = "bn"
    case BengaliBangladesh = "bn_BD"
    case BengaliIndia = "bn_IN"
    case Bodo = "brx"
    case BodoIndia = "brx_IN"
    case Bosnian = "bs_Latn"
    case BosnianBosniaHerzegovina = "bs_Latn_BA"
    case BosnianCyrillic = "bs_Cyrl"
    case BosnianCyrillicBosniaHerzegovina = "bs_Cyrl_BA"
    case Breton = "br"
    case BretonFrance = "br_FR"
    case Bulgarian = "bg"
    case BulgarianBulgaria = "bg_BG"
    case Burmese = "my"
    case BurmeseMyanmarBurma = "my_MM"
    case Catalan = "ca"
    case CatalanAndorra = "ca_AD"
    case CatalanFrance = "ca_FR"
    case CatalanItaly = "ca_IT"
    case CatalanSpain = "ca_ES"
    case CentralAtlasTamazight = "tzm_Latn"
    case CentralAtlasTamazightMorocco = "tzm_Latn_MA"
    case CentralKurdish = "ckb"
    case CentralKurdishIran = "ckb_IR"
    case CentralKurdishIraq = "ckb_IQ"
    case Cherokee = "chr"
    case CherokeeUnitedStates = "chr_US"
    case Chiga = "cgg"
    case ChigaUganda = "cgg_UG"
    case Chinese = "zh"
    case ChineseChina = "zh_Hans_CN"
    case ChineseHongKongSarChina = "zh_Hant_HK"
    case ChineseMacauSarChina = "zh_Hant_MO"
    case ChineseSimplified = "zh_Hans"
    case ChineseSimplifiedHongKongSarChina = "zh_Hans_HK"
    case ChineseSimplifiedMacauSarChina = "zh_Hans_MO"
    case ChineseSingapore = "zh_Hans_SG"
    case ChineseTaiwan = "zh_Hant_TW"
    case ChineseTraditional = "zh_Hant"
    case Colognian = "ksh"
    case ColognianGermany = "ksh_DE"
    case Cornish = "kw"
    case CornishUnitedKingdom = "kw_GB"
    case Croatian = "hr"
    case CroatianBosniaHerzegovina = "hr_BA"
    case CroatianCroatia = "hr_HR"
    case Czech = "cs"
    case CzechCzechRepublic = "cs_CZ"
    case Danish = "da"
    case DanishDenmark = "da_DK"
    case DanishGreenland = "da_GL"
    case Duala = "dua"
    case DualaCameroon = "dua_CM"
    case Dutch = "nl"
    case DutchAruba = "nl_AW"
    case DutchBelgium = "nl_BE"
    case DutchCaribbeanNetherlands = "nl_BQ"
    case DutchCuraao = "nl_CW"
    case DutchNetherlands = "nl_NL"
    case DutchSintMaarten = "nl_SX"
    case DutchSuriname = "nl_SR"
    case Dzongkha = "dz"
    case DzongkhaBhutan = "dz_BT"
    case Embu = "ebu"
    case EmbuKenya = "ebu_KE"
    case English = "en"
    case EnglishAlbania = "en_AL"
    case EnglishAmericanSamoa = "en_AS"
    case EnglishAndorra = "en_AD"
    case EnglishAnguilla = "en_AI"
    case EnglishAntiguaBarbuda = "en_AG"
    case EnglishAustralia = "en_AU"
    case EnglishAustria = "en_AT"
    case EnglishBahamas = "en_BS"
    case EnglishBarbados = "en_BB"
    case EnglishBelgium = "en_BE"
    case EnglishBelize = "en_BZ"
    case EnglishBermuda = "en_BM"
    case EnglishBosniaHerzegovina = "en_BA"
    case EnglishBotswana = "en_BW"
    case EnglishBritishIndianOceanTerritory = "en_IO"
    case EnglishBritishVirginIslands = "en_VG"
    case EnglishCameroon = "en_CM"
    case EnglishCanada = "en_CA"
    case EnglishCaymanIslands = "en_KY"
    case EnglishChristmasIsland = "en_CX"
    case EnglishCocosKeelingIslands = "en_CC"
    case EnglishCookIslands = "en_CK"
    case EnglishCroatia = "en_HR"
    case EnglishCyprus = "en_CY"
    case EnglishCzechRepublic = "en_CZ"
    case EnglishDenmark = "en_DK"
    case EnglishDiegoGarcia = "en_DG"
    case EnglishDominica = "en_DM"
    case EnglishEritrea = "en_ER"
    case EnglishEstonia = "en_EE"
    case EnglishEurope = "en_150"
    case EnglishFalklandIslands = "en_FK"
    case EnglishFiji = "en_FJ"
    case EnglishFinland = "en_FI"
    case EnglishFrance = "en_FR"
    case EnglishGambia = "en_GM"
    case EnglishGermany = "en_DE"
    case EnglishGhana = "en_GH"
    case EnglishGibraltar = "en_GI"
    case EnglishGreece = "en_GR"
    case EnglishGrenada = "en_GD"
    case EnglishGuam = "en_GU"
    case EnglishGuernsey = "en_GG"
    case EnglishGuyana = "en_GY"
    case EnglishHongKongSarChina = "en_HK"
    case EnglishHungary = "en_HU"
    case EnglishIceland = "en_IS"
    case EnglishIndia = "en_IN"
    case EnglishIreland = "en_IE"
    case EnglishIsleOfMan = "en_IM"
    case EnglishIsrael = "en_IL"
    case EnglishItaly = "en_IT"
    case EnglishJamaica = "en_JM"
    case EnglishJersey = "en_JE"
    case EnglishKenya = "en_KE"
    case EnglishKiribati = "en_KI"
    case EnglishLatvia = "en_LV"
    case EnglishLesotho = "en_LS"
    case EnglishLiberia = "en_LR"
    case EnglishLithuania = "en_LT"
    case EnglishLuxembourg = "en_LU"
    case EnglishMacauSarChina = "en_MO"
    case EnglishMadagascar = "en_MG"
    case EnglishMalawi = "en_MW"
    case EnglishMalaysia = "en_MY"
    case EnglishMalta = "en_MT"
    case EnglishMarshallIslands = "en_MH"
    case EnglishMauritius = "en_MU"
    case EnglishMicronesia = "en_FM"
    case EnglishMontenegro = "en_ME"
    case EnglishMontserrat = "en_MS"
    case EnglishNamibia = "en_NA"
    case EnglishNauru = "en_NR"
    case EnglishNetherlands = "en_NL"
    case EnglishNewZealand = "en_NZ"
    case EnglishNigeria = "en_NG"
    case EnglishNiue = "en_NU"
    case EnglishNorfolkIsland = "en_NF"
    case EnglishNorthernMarianaIslands = "en_MP"
    case EnglishNorway = "en_NO"
    case EnglishPakistan = "en_PK"
    case EnglishPalau = "en_PW"
    case EnglishPapuaNewGuinea = "en_PG"
    case EnglishPhilippines = "en_PH"
    case EnglishPitcairnIslands = "en_PN"
    case EnglishPoland = "en_PL"
    case EnglishPortugal = "en_PT"
    case EnglishPuertoRico = "en_PR"
    case EnglishRomania = "en_RO"
    case EnglishRussia = "en_RU"
    case EnglishRwanda = "en_RW"
    case EnglishSamoa = "en_WS"
    case EnglishSeychelles = "en_SC"
    case EnglishSierraLeone = "en_SL"
    case EnglishSingapore = "en_SG"
    case EnglishSintMaarten = "en_SX"
    case EnglishSlovakia = "en_SK"
    case EnglishSlovenia = "en_SI"
    case EnglishSolomonIslands = "en_SB"
    case EnglishSouthAfrica = "en_ZA"
    case EnglishSouthSudan = "en_SS"
    case EnglishSpain = "en_ES"
    case EnglishStHelena = "en_SH"
    case EnglishStKittsNevis = "en_KN"
    case EnglishStLucia = "en_LC"
    case EnglishStVincentGrenadines = "en_VC"
    case EnglishSudan = "en_SD"
    case EnglishSwaziland = "en_SZ"
    case EnglishSweden = "en_SE"
    case EnglishSwitzerland = "en_CH"
    case EnglishTanzania = "en_TZ"
    case EnglishTokelau = "en_TK"
    case EnglishTonga = "en_TO"
    case EnglishTrinidadTobago = "en_TT"
    case EnglishTurkey = "en_TR"
    case EnglishTurksCaicosIslands = "en_TC"
    case EnglishTuvalu = "en_TV"
    case EnglishUSOutlyingIslands = "en_UM"
    case EnglishUSVirginIslands = "en_VI"
    case EnglishUganda = "en_UG"
    case EnglishUnitedKingdom = "en_GB"
    case EnglishUnitedStates = "en_US"
    case EnglishUnitedStatesComputer = "en_US_POSIX"
    case EnglishVanuatu = "en_VU"
    case EnglishWorld = "en_001"
    case EnglishZambia = "en_ZM"
    case EnglishZimbabwe = "en_ZW"
    case Esperanto = "eo"
    case Estonian = "et"
    case EstonianEstonia = "et_EE"
    case Ewe = "ee"
    case EweGhana = "ee_GH"
    case EweTogo = "ee_TG"
    case Ewondo = "ewo"
    case EwondoCameroon = "ewo_CM"
    case Faroese = "fo"
    case FaroeseFaroeIslands = "fo_FO"
    case Filipino = "fil"
    case FilipinoPhilippines = "fil_PH"
    case Finnish = "fi"
    case FinnishFinland = "fi_FI"
    case French = "fr"
    case FrenchAlgeria = "fr_DZ"
    case FrenchBelgium = "fr_BE"
    case FrenchBenin = "fr_BJ"
    case FrenchBurkinaFaso = "fr_BF"
    case FrenchBurundi = "fr_BI"
    case FrenchCameroon = "fr_CM"
    case FrenchCanada = "fr_CA"
    case FrenchCentralAfricanRepublic = "fr_CF"
    case FrenchChad = "fr_TD"
    case FrenchComoros = "fr_KM"
    case FrenchCongoBrazzaville = "fr_CG"
    case FrenchCongoKinshasa = "fr_CD"
    case FrenchCteDivoire = "fr_CI"
    case FrenchDjibouti = "fr_DJ"
    case FrenchEquatorialGuinea = "fr_GQ"
    case FrenchFrance = "fr_FR"
    case FrenchFrenchGuiana = "fr_GF"
    case FrenchFrenchPolynesia = "fr_PF"
    case FrenchGabon = "fr_GA"
    case FrenchGuadeloupe = "fr_GP"
    case FrenchGuinea = "fr_GN"
    case FrenchHaiti = "fr_HT"
    case FrenchLuxembourg = "fr_LU"
    case FrenchMadagascar = "fr_MG"
    case FrenchMali = "fr_ML"
    case FrenchMartinique = "fr_MQ"
    case FrenchMauritania = "fr_MR"
    case FrenchMauritius = "fr_MU"
    case FrenchMayotte = "fr_YT"
    case FrenchMonaco = "fr_MC"
    case FrenchMorocco = "fr_MA"
    case FrenchNewCaledonia = "fr_NC"
    case FrenchNiger = "fr_NE"
    case FrenchRunion = "fr_RE"
    case FrenchRwanda = "fr_RW"
    case FrenchSenegal = "fr_SN"
    case FrenchSeychelles = "fr_SC"
    case FrenchStBarthlemy = "fr_BL"
    case FrenchStMartin = "fr_MF"
    case FrenchStPierreMiquelon = "fr_PM"
    case FrenchSwitzerland = "fr_CH"
    case FrenchSyria = "fr_SY"
    case FrenchTogo = "fr_TG"
    case FrenchTunisia = "fr_TN"
    case FrenchVanuatu = "fr_VU"
    case FrenchWallisFutuna = "fr_WF"
    case Friulian = "fur"
    case FriulianItaly = "fur_IT"
    case Fulah = "ff"
    case FulahCameroon = "ff_CM"
    case FulahGuinea = "ff_GN"
    case FulahMauritania = "ff_MR"
    case FulahSenegal = "ff_SN"
    case Galician = "gl"
    case GalicianSpain = "gl_ES"
    case Ganda = "lg"
    case GandaUganda = "lg_UG"
    case Georgian = "ka"
    case GeorgianGeorgia = "ka_GE"
    case German = "de"
    case GermanAustria = "de_AT"
    case GermanBelgium = "de_BE"
    case GermanGermany = "de_DE"
    case GermanLiechtenstein = "de_LI"
    case GermanLuxembourg = "de_LU"
    case GermanSwitzerland = "de_CH"
    case Greek = "el"
    case GreekCyprus = "el_CY"
    case GreekGreece = "el_GR"
    case Gujarati = "gu"
    case GujaratiIndia = "gu_IN"
    case Gusii = "guz"
    case GusiiKenya = "guz_KE"
    case Hausa = "ha_Latn"
    case HausaGhana = "ha_Latn_GH"
    case HausaNiger = "ha_Latn_NE"
    case HausaNigeria = "ha_Latn_NG"
    case Hawaiian = "haw"
    case HawaiianUnitedStates = "haw_US"
    case Hebrew = "he"
    case HebrewIsrael = "he_IL"
    case Hindi = "hi"
    case HindiIndia = "hi_IN"
    case Hungarian = "hu"
    case HungarianHungary = "hu_HU"
    case Icelandic = "is"
    case IcelandicIceland = "is_IS"
    case Igbo = "ig"
    case IgboNigeria = "ig_NG"
    case InariSami = "smn"
    case InariSamiFinland = "smn_FI"
    case Indonesian = "id"
    case IndonesianIndonesia = "id_ID"
    case Inuktitut = "iu"
    case InuktitutUnifiedCanadianAboriginalSyllabics = "iu_Cans"
    case InuktitutUnifiedCanadianAboriginalSyllabicsCanada = "iu_Cans_CA"
    case Irish = "ga"
    case IrishIreland = "ga_IE"
    case Italian = "it"
    case ItalianItaly = "it_IT"
    case ItalianSanMarino = "it_SM"
    case ItalianSwitzerland = "it_CH"
    case Japanese = "ja"
    case JapaneseJapan = "ja_JP"
    case JolaFonyi = "dyo"
    case JolaFonyiSenegal = "dyo_SN"
    case Kabuverdianu = "kea"
    case KabuverdianuCapeVerde = "kea_CV"
    case Kabyle = "kab"
    case KabyleAlgeria = "kab_DZ"
    case Kako = "kkj"
    case KakoCameroon = "kkj_CM"
    case Kalaallisut = "kl"
    case KalaallisutGreenland = "kl_GL"
    case Kalenjin = "kln"
    case KalenjinKenya = "kln_KE"
    case Kamba = "kam"
    case KambaKenya = "kam_KE"
    case Kannada = "kn"
    case KannadaIndia = "kn_IN"
    case Kashmiri = "ks"
    case KashmiriArabic = "ks_Arab"
    case KashmiriArabicIndia = "ks_Arab_IN"
    case Kazakh = "kk_Cyrl"
    case KazakhKazakhstan = "kk_Cyrl_KZ"
    case Khmer = "km"
    case KhmerCambodia = "km_KH"
    case Kikuyu = "ki"
    case KikuyuKenya = "ki_KE"
    case Kinyarwanda = "rw"
    case KinyarwandaRwanda = "rw_RW"
    case Konkani = "kok"
    case KonkaniIndia = "kok_IN"
    case Korean = "ko"
    case KoreanNorthKorea = "ko_KP"
    case KoreanSouthKorea = "ko_KR"
    case KoyraChiini = "khq"
    case KoyraChiiniMali = "khq_ML"
    case KoyraboroSenni = "ses"
    case KoyraboroSenniMali = "ses_ML"
    case Kwasio = "nmg"
    case KwasioCameroon = "nmg_CM"
    case Kyrgyz = "ky_Cyrl"
    case KyrgyzKyrgyzstan = "ky_Cyrl_KG"
    case Lakota = "lkt"
    case LakotaUnitedStates = "lkt_US"
    case Langi = "lag"
    case LangiTanzania = "lag_TZ"
    case Lao = "lo"
    case LaoLaos = "lo_LA"
    case Latvian = "lv"
    case LatvianLatvia = "lv_LV"
    case Lingala = "ln"
    case LingalaAngola = "ln_AO"
    case LingalaCentralAfricanRepublic = "ln_CF"
    case LingalaCongoBrazzaville = "ln_CG"
    case LingalaCongoKinshasa = "ln_CD"
    case Lithuanian = "lt"
    case LithuanianLithuania = "lt_LT"
    case LowerSorbian = "dsb"
    case LowerSorbianGermany = "dsb_DE"
    case LubaKatanga = "lu"
    case LubaKatangaCongoKinshasa = "lu_CD"
    case Luo = "luo"
    case LuoKenya = "luo_KE"
    case Luxembourgish = "lb"
    case LuxembourgishLuxembourg = "lb_LU"
    case Luyia = "luy"
    case LuyiaKenya = "luy_KE"
    case Macedonian = "mk"
    case MacedonianMacedonia = "mk_MK"
    case Machame = "jmc"
    case MachameTanzania = "jmc_TZ"
    case MakhuwaMeetto = "mgh"
    case MakhuwaMeettoMozambique = "mgh_MZ"
    case Makonde = "kde"
    case MakondeTanzania = "kde_TZ"
    case Malagasy = "mg"
    case MalagasyMadagascar = "mg_MG"
    case Malay = "ms_Latn"
    case MalayArabic = "ms_Arab"
    case MalayArabicBrunei = "ms_Arab_BN"
    case MalayArabicMalaysia = "ms_Arab_MY"
    case MalayBrunei = "ms_Latn_BN"
    case MalayMalaysia = "ms_Latn_MY"
    case MalaySingapore = "ms_Latn_SG"
    case Malayalam = "ml"
    case MalayalamIndia = "ml_IN"
    case Maltese = "mt"
    case MalteseMalta = "mt_MT"
    case Manx = "gv"
    case ManxIsleOfMan = "gv_IM"
    case Marathi = "mr"
    case MarathiIndia = "mr_IN"
    case Masai = "mas"
    case MasaiKenya = "mas_KE"
    case MasaiTanzania = "mas_TZ"
    case Meru = "mer"
    case MeruKenya = "mer_KE"
    case Meta = "mgo"
    case MetaCameroon = "mgo_CM"
    case Mongolian = "mn_Cyrl"
    case MongolianMongolia = "mn_Cyrl_MN"
    case Morisyen = "mfe"
    case MorisyenMauritius = "mfe_MU"
    case Mundang = "mua"
    case MundangCameroon = "mua_CM"
    case Nama = "naq"
    case NamaNamibia = "naq_NA"
    case Nepali = "ne"
    case NepaliIndia = "ne_IN"
    case NepaliNepal = "ne_NP"
    case Ngiemboon = "nnh"
    case NgiemboonCameroon = "nnh_CM"
    case Ngomba = "jgo"
    case NgombaCameroon = "jgo_CM"
    case NorthNdebele = "nd"
    case NorthNdebeleZimbabwe = "nd_ZW"
    case NorthernSami = "se"
    case NorthernSamiFinland = "se_FI"
    case NorthernSamiNorway = "se_NO"
    case NorthernSamiSweden = "se_SE"
    case NorwegianBokml = "nb"
    case NorwegianBokmlNorway = "nb_NO"
    case NorwegianBokmlSvalbardJanMayen = "nb_SJ"
    case NorwegianNynorsk = "nn"
    case NorwegianNynorskNorway = "nn_NO"
    case Nuer = "nus"
    case NuerSudan = "nus_SD"
    case Nyankole = "nyn"
    case NyankoleUganda = "nyn_UG"
    case Oriya = "or"
    case OriyaIndia = "or_IN"
    case Oromo = "om"
    case OromoEthiopia = "om_ET"
    case OromoKenya = "om_KE"
    case Ossetic = "os"
    case OsseticGeorgia = "os_GE"
    case OsseticRussia = "os_RU"
    case Pashto = "ps"
    case PashtoAfghanistan = "ps_AF"
    case Persian = "fa"
    case PersianAfghanistan = "fa_AF"
    case PersianIran = "fa_IR"
    case Polish = "pl"
    case PolishPoland = "pl_PL"
    case Portuguese = "pt"
    case PortugueseAngola = "pt_AO"
    case PortugueseBrazil = "pt_BR"
    case PortugueseCapeVerde = "pt_CV"
    case PortugueseGuineaBissau = "pt_GW"
    case PortugueseMacauSarChina = "pt_MO"
    case PortugueseMozambique = "pt_MZ"
    case PortuguesePortugal = "pt_PT"
    case PortugueseSoTomPrncipe = "pt_ST"
    case PortugueseTimorLeste = "pt_TL"
    case Punjabi = "pa_Guru"
    case PunjabiArabic = "pa_Arab"
    case PunjabiArabicPakistan = "pa_Arab_PK"
    case PunjabiIndia = "pa_Guru_IN"
    case Quechua = "qu"
    case QuechuaBolivia = "qu_BO"
    case QuechuaEcuador = "qu_EC"
    case QuechuaPeru = "qu_PE"
    case Romanian = "ro"
    case RomanianMoldova = "ro_MD"
    case RomanianRomania = "ro_RO"
    case Romansh = "rm"
    case RomanshSwitzerland = "rm_CH"
    case Rombo = "rof"
    case RomboTanzania = "rof_TZ"
    case Rundi = "rn"
    case RundiBurundi = "rn_BI"
    case Russian = "ru"
    case RussianBelarus = "ru_BY"
    case RussianKazakhstan = "ru_KZ"
    case RussianKyrgyzstan = "ru_KG"
    case RussianMoldova = "ru_MD"
    case RussianRussia = "ru_RU"
    case RussianUkraine = "ru_UA"
    case Rwa = "rwk"
    case RwaTanzania = "rwk_TZ"
    case Sakha = "sah"
    case SakhaRussia = "sah_RU"
    case Samburu = "saq"
    case SamburuKenya = "saq_KE"
    case Sango = "sg"
    case SangoCentralAfricanRepublic = "sg_CF"
    case Sangu = "sbp"
    case SanguTanzania = "sbp_TZ"
    case ScottishGaelic = "gd"
    case ScottishGaelicUnitedKingdom = "gd_GB"
    case Sena = "seh"
    case SenaMozambique = "seh_MZ"
    case Serbian = "sr_Cyrl"
    case SerbianBosniaHerzegovina = "sr_Cyrl_BA"
    case SerbianKosovo = "sr_Cyrl_XK"
    case SerbianLatin = "sr_Latn"
    case SerbianLatinBosniaHerzegovina = "sr_Latn_BA"
    case SerbianLatinKosovo = "sr_Latn_XK"
    case SerbianLatinMontenegro = "sr_Latn_ME"
    case SerbianLatinSerbia = "sr_Latn_RS"
    case SerbianMontenegro = "sr_Cyrl_ME"
    case SerbianSerbia = "sr_Cyrl_RS"
    case Shambala = "ksb"
    case ShambalaTanzania = "ksb_TZ"
    case Shona = "sn"
    case ShonaZimbabwe = "sn_ZW"
    case SichuanYi = "ii"
    case SichuanYiChina = "ii_CN"
    case Sinhala = "si"
    case SinhalaSriLanka = "si_LK"
    case Slovak = "sk"
    case SlovakSlovakia = "sk_SK"
    case Slovenian = "sl"
    case SlovenianSlovenia = "sl_SI"
    case Soga = "xog"
    case SogaUganda = "xog_UG"
    case Somali = "so"
    case SomaliDjibouti = "so_DJ"
    case SomaliEthiopia = "so_ET"
    case SomaliKenya = "so_KE"
    case SomaliSomalia = "so_SO"
    case Spanish = "es"
    case SpanishArgentina = "es_AR"
    case SpanishBolivia = "es_BO"
    case SpanishCanaryIslands = "es_IC"
    case SpanishCeutaMelilla = "es_EA"
    case SpanishChile = "es_CL"
    case SpanishColombia = "es_CO"
    case SpanishCostaRica = "es_CR"
    case SpanishCuba = "es_CU"
    case SpanishDominicanRepublic = "es_DO"
    case SpanishEcuador = "es_EC"
    case SpanishElSalvador = "es_SV"
    case SpanishEquatorialGuinea = "es_GQ"
    case SpanishGuatemala = "es_GT"
    case SpanishHonduras = "es_HN"
    case SpanishLatinAmerica = "es_419"
    case SpanishMexico = "es_MX"
    case SpanishNicaragua = "es_NI"
    case SpanishPanama = "es_PA"
    case SpanishParaguay = "es_PY"
    case SpanishPeru = "es_PE"
    case SpanishPhilippines = "es_PH"
    case SpanishPuertoRico = "es_PR"
    case SpanishSpain = "es_ES"
    case SpanishUnitedStates = "es_US"
    case SpanishUruguay = "es_UY"
    case SpanishVenezuela = "es_VE"
    case StandardMoroccanTamazight = "zgh"
    case StandardMoroccanTamazightMorocco = "zgh_MA"
    case Swahili = "sw"
    case SwahiliCongoKinshasa = "sw_CD"
    case SwahiliKenya = "sw_KE"
    case SwahiliTanzania = "sw_TZ"
    case SwahiliUganda = "sw_UG"
    case Swedish = "sv"
    case SwedishlandIslands = "sv_AX"
    case SwedishFinland = "sv_FI"
    case SwedishSweden = "sv_SE"
    case SwissGerman = "gsw"
    case SwissGermanFrance = "gsw_FR"
    case SwissGermanLiechtenstein = "gsw_LI"
    case SwissGermanSwitzerland = "gsw_CH"
    case Tachelhit = "shi_Latn"
    case TachelhitMorocco = "shi_Latn_MA"
    case TachelhitTifinagh = "shi_Tfng"
    case TachelhitTifinaghMorocco = "shi_Tfng_MA"
    case Taita = "dav"
    case TaitaKenya = "dav_KE"
    case Tajik = "tg_Cyrl"
    case TajikTajikistan = "tg_Cyrl_TJ"
    case Tamil = "ta"
    case TamilIndia = "ta_IN"
    case TamilMalaysia = "ta_MY"
    case TamilSingapore = "ta_SG"
    case TamilSriLanka = "ta_LK"
    case Tasawaq = "twq"
    case TasawaqNiger = "twq_NE"
    case Telugu = "te"
    case TeluguIndia = "te_IN"
    case Teso = "teo"
    case TesoKenya = "teo_KE"
    case TesoUganda = "teo_UG"
    case Thai = "th"
    case ThaiThailand = "th_TH"
    case Tibetan = "bo"
    case TibetanChina = "bo_CN"
    case TibetanIndia = "bo_IN"
    case Tigrinya = "ti"
    case TigrinyaEritrea = "ti_ER"
    case TigrinyaEthiopia = "ti_ET"
    case Tongan = "to"
    case TonganTonga = "to_TO"
    case Turkish = "tr"
    case TurkishCyprus = "tr_CY"
    case TurkishTurkey = "tr_TR"
    case Turkmen = "tk_Latn"
    case TurkmenTurkmenistan = "tk_Latn_TM"
    case Ukrainian = "uk"
    case UkrainianUkraine = "uk_UA"
    case UpperSorbian = "hsb"
    case UpperSorbianGermany = "hsb_DE"
    case Urdu = "ur"
    case UrduIndia = "ur_IN"
    case UrduPakistan = "ur_PK"
    case Uyghur = "ug"
    case UyghurArabic = "ug_Arab"
    case UyghurArabicChina = "ug_Arab_CN"
    case Uzbek = "uz_Cyrl"
    case UzbekArabic = "uz_Arab"
    case UzbekArabicAfghanistan = "uz_Arab_AF"
    case UzbekLatin = "uz_Latn"
    case UzbekLatinUzbekistan = "uz_Latn_UZ"
    case UzbekUzbekistan = "uz_Cyrl_UZ"
    case Vai = "vai_Vaii"
    case VaiLatin = "vai_Latn"
    case VaiLatinLiberia = "vai_Latn_LR"
    case VaiLiberia = "vai_Vaii_LR"
    case Vietnamese = "vi"
    case VietnameseVietnam = "vi_VN"
    case Vunjo = "vun"
    case VunjoTanzania = "vun_TZ"
    case Walser = "wae"
    case WalserSwitzerland = "wae_CH"
    case Welsh = "cy"
    case WelshUnitedKingdom = "cy_GB"
    case WesternFrisian = "fy"
    case WesternFrisianNetherlands = "fy_NL"
    case Yangben = "yav"
    case YangbenCameroon = "yav_CM"
    case Yiddish = "yi"
    case YiddishWorld = "yi_001"
    case Yoruba = "yo"
    case YorubaBenin = "yo_BJ"
    case YorubaNigeria = "yo_NG"
    case Zarma = "dje"
    case ZarmaNiger = "dje_NE"
    case Zulu = "zu"
    case ZuluSouthAfrica = "zu_ZA"
}
