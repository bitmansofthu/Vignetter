# Vignetter

**Telepítési útmutató**

XCode-ban a projekt megnyitását követően a Vignetter targetet lehet futtatni szimulátorban aláírás nélkül.
Az app minimum iOS követelménye a 16-os verzió, a fejlesztés maga 26.2-es szimulátoron lett tesztelve.
A backend API szimulálásához a mellékelt PHP fájlt használtam, melyet a saját tárhelyemen tettem elérhetővé a fejlesztéshez.
Az API url az AppConfigban állítható be.

**Architektúra**

SwiftUI és MVVM + Coordinator (NavigationStack)
A tesztelhetőség és a hatékony kódkarbantartás érdekében esett erre a választásom. A ViewModel ezen felül biztosítja, hogy az üzleti logika elválasztódjon a Viewoktól, így az akár többféle megjelenítéshez is használható megkönnyítve például egy iPad változat implementálását.

**További fejlesztési lehetőségek**

Branchek:

*difactory* - DI megoldás Factory-val.

*navigationbarfix* - A designban szereplő navigation bar használata a standard iOS-es helyett.


UI: A navigation barnal jelenleg a standard iOS-es valtozatot használtam, amelyet korlátozottan lehet csak módosítani SwiftUI-ból. Egy lehetséges megoldás a navigation bar eltűntetése és egy layoutba illesztett újrahasznosítható és konfigurálható custom View használata.
Ennek megvalósítása a *navigationbarfix* branchen található.

A hálózati kommunikációra a beépített URLSession hívásokat használtam, nincs szükség külső package-re. A DTO-k a Swagger yaml alapján lettek legenerálva. Továbbfejlesztési lehetőségként az Apple által biztosított swift-openapi-generator-t lehetne alkalmazni, amely pluginként beépülve automatikusan generálja le a szükséges DTO-kat és függvényhívásokat.

Repository: Jelenleg csak a highway info tárolásához használok "in memory" repositoryt, amely lehetővé teszi az adatok elérését a ViewModelek között azok újboli letöltése nélkül. Jelenleg a frissítési intervallum kezelése nincs implementálva. A repositoryk segítségével igény esetén az offline mode is megvalósítható.

Dependency Injection: A modulok átadása jelenleg constructoron keresztül történik az App komponensből a Coordinatoron keresztül. Továbbfejlesztésként a FactoryKit DI framework-öt alkalmaznám, amely jelentősen megkönnyíti az injektálást és többféle opció is van a modulok életciklusának kezeléséhez.
Egy lehetséges megoldás erre a *difactory* branchen található.

Térkép: A Figmaból kiexportált SVG-t megyénként külön képekre bontottam, a teljes térképméretet megtartva és ZStack-ban rétegenként jelenítem meg, így az összes kép együtt kiadja az ország térképet. A kitöltési színeket fehérre cseréltem, így .colorMultiply modifier-rel állítható az alap/kiválasztott szín és ezáltal akár Dark mode-hoz is igazíthatóak. A határvonalakat külön exportáltam egy teljes képként. Másik lehetőség az SVGKit külső package használata, amely CALayer-ekre bontja a képet, melyek előre meghatározott id-k alapján elérhetőek és így a színek kiválasztásának megfelelően variálhatóak. Ez azonban UIKit bindingot igényel és egy igen heavy weight dependency.

Tesztelés: Mivel minden beépülő modulhoz tartozik protocol, így könnyen generálhatóak mock objektumok. (Pl. a previewknál is ezt használja ki a projekt) Ezáltal a ViewModel-ek és a UseCase-ek is hatékonyan tesztelhetőek XCTest-el vagy SwiftTest-el egyaránt. A mock objektumok generálásához pl SwiftMocky-t lehet használni, és a fentebb említett Factory framework-el egyszerűen regisztrálhatóak a tesztesetekhez.