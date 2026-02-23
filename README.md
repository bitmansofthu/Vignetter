# Vignetter

**Telepítési útmutató**
XCode-ban a projekt megnyitását követően a Vignetter targetet lehet futtatni szimulátorban aláírás nélkül.
Az app minimum iOS követelménye a 16-os verzió, a fejlesztés maga 26.2-es szimulátoron lett tesztelve.
A backend szimulálásához a mellékelt PHP fájlt használtam, melyet a saját tárhelyemen tettem elérhetővé a fejlesztéshez.
A backend url az AppConfigban állítható be.

**Architektúra**
SwiftUI és MVVM + Coordinator (NavigationStack)
A tesztelhetőség és a hatékony kódkarbantartás érdekében esett erre a választásom. A ViewModel ezen felül biztosítja, hogy az üzleti logika elválasztódjon a Viewoktól, így az akár többféle megjelenítéshez is használható megkönnyítve például egy iPad változat implementálását.

**További fejlesztési lehetőségek**

UI: A navigation barnal jelenleg a standard iOS-es valtozatot használtam, amelyet korlátozottan lehet csak módosítani SwiftUI-ból. Egy lehetséges megoldás a navigation bar eltűntetése és egy layoutba illesztett újrahasznosítható és konfigurálható custom View használata.
Egy lehetséges megvalósítása ennek a *navigationbarfix* branchen található.

A hálózati kommunikációra a beépített URLSession hívásokat használtam, nincs szükség külső package-re. A DTO-k a Swagger yaml alapján lettek elkészítve. Továbbfejlesztési lehetőségként az Apple által biztosított swift-openapi-generator-t lehetne alkalmazni, amely automatikusan megoldja a típusok és a megfelelő függvényhívások generálását, ezáltal eltűntetve több felesleges boilerplate kódot.

Repository: Jelenleg csak a highway info tárolásához használok in memory repositoryt, amely lehetővé teszi az adatok elérését a ViewModelek között azok újboli letöltése nélkül. Jelenleg a frissítési intervallum kezelése nincs implementálva. Emellett a repositorykon keresztül az offline mód implementálása is lehetővé válik.

Dependency Injection: A modulok átadása jelenleg constructoron keresztül történik az App komponensből a Coordinatoron keresztül. Továbbfejlesztésként a FactoryKit DI frameworköt alkalmaznám, ahol jelentősen egyszerűsödik az injektálás és többféle opció is van a modulok életciklusának kezeléséhez.

Térkép: A Figmaból kiexportált SVG-t megyénként külön képekre bontottam, a teljes térképméretet megtartva és ZStack-ban rétegenként jelenítem meg, így az összes kép együtt kiadja az ország térképet. A kitöltési színeket fehérre cseréltem, így .colorMultiply-al állítható az alap/kiválasztott szín és ezáltal akár Dark mode-hoz is igazítható. A határvonalakat külön exportáltam egy teljes képként. Másik lehetőség az SVGKit külső package használata, amely CALayer-ekre bontja a képet, melyek előre meghatározott id-k alapján elérhetőek és a kitöltési szín a kiválasztásnak megfelelően állítható. Ez azonban ahhoz, hogy SwiftUI-ban is használható legyen, UIKit bindingot igényel.

Tesztelés: Mivel minden beépülő modulhoz tartozik protocol, így könnyen generálhatóak mock objektumok. (Pl. a previewknál is ezt használja ki a projekt) Ezáltal a ViewModel-ek és a UseCase-ek is hatékonyan tesztelhetőek XCTest-el vagy SwiftTest-el egyaránt.