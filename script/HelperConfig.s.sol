// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console2} from "forge-std/Script.sol";
import {SelfDestruct} from "../src/SelfDestruct.sol";
import {Force} from "../src/Force.sol";
import {Vault} from "../src/Vault.sol";
import {King} from "../src/King.sol";
import {Pawn} from "../src/Pawn.sol";
import {Reentrance} from "../src/Reentrance.sol";
import {ReentranceHack} from "../src/ReentranceHack.sol";
import {Elevator} from "../src/Elevator.sol";
import {ElevatorHack} from "../src/ElevatorHack.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";
import {GatekeeperOneHack} from "../src/GatekeeperOneHack.sol";
import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";
import {GatekeeperTwoHack} from "../src/GatekeeperTwoHack.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";
import {Denial} from "../src/Denial.sol";
import {DenialHack} from "../src/DenialHack.sol";
import {Shop, ShopHack} from "../src/Shop.sol";
import {Dex} from "../src/Dex.sol";
import {DexTwo} from "../src/DexTwo.sol";
import {PuzzleWallet} from "../src/PuzzleWallet.sol";

contract HelperConfig is Script {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    error HelperConfig__InvalidChainId();

    /*//////////////////////////////////////////////////////////////
                                 TYPES
    //////////////////////////////////////////////////////////////*/
    struct ForceConfig {
        address account;
        SelfDestruct selfDestruct;
    }

    struct VaultConfig {
        address account;
        Vault vault;
    }

    struct BasicConfig {
        address account;
    }

    struct KingConfig {
        address account;
        King king;
        Pawn pawn;
    }

    struct ReentranceConfig {
        address account;
        Reentrance reentrance;
        ReentranceHack reentranceHack;
    }

    struct ElevatorConfig {
        address account;
        Elevator elevator;
        ElevatorHack elevatorHack;
    }

    struct GatekeeperOneConfig {
        address account;
        GatekeeperOne gatekeeperOne;
        GatekeeperOneHack gatekeeperOneHack;
    }

    struct GatekeeperTwoConfig {
        address account;
        GatekeeperTwo gatekeeperTwo;
        GatekeeperTwoHack gatekeeperTwoHack;
    }

    struct NaughtCoinConfig {
        address account;
        NaughtCoin naughtCoin;
    }

    struct DenialConfig {
        address account;
        Denial denial;
        DenialHack denialHack;
    }

    struct ShopConfig {
        address account;
        Shop shop;
        ShopHack shopHack;
    }

    struct DexConfig {
        address account;
        Dex dex;
    }

    struct DexTwoConfig {
        address account;
        DexTwo dexTwo;
    }

    struct PuzzleWalletConfig {
        address account;
        PuzzleWallet puzzleWallet;
    }

    /*//////////////////////////////////////////////////////////////
                            state variables
    //////////////////////////////////////////////////////////////*/
    uint256 public constant ETH_MAINNET_CHAIN_ID = 1;
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant LOCAL_CHAIN_ID = 31337;
    address public constant BURNER_WALLET = 0x0298E0C16097c3C2C3Fc200f901aE54Ae7659f99;
    uint256 public constant ARBITRUM_MAINNET_CHAIN_ID = 42_161;
    address public constant ANVIL_DEFAULT_ACCOUNT = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address public constant FOUNDRY_DEFAULT_WALLET = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;

    ForceConfig public forceConfig;
    BasicConfig public basicConfig;

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    constructor() {
        // forceConfig = getForceConfig();
        // basicConfig = getOrCreateAnvilEthConfig();
    }

    /*//////////////////////////////////////////////////////////////
                                CONFIGS
    //////////////////////////////////////////////////////////////*/
    function getForceConfig() public returns (ForceConfig memory) {
        vm.startBroadcast();
        SelfDestruct selfDestruct = new SelfDestruct{value: 0.00001 ether}(0x0D8A5c55b334d3850960D39dA8571f17A7f304fF);
        vm.stopBroadcast();
        return ForceConfig({account: BURNER_WALLET, selfDestruct: selfDestruct});
    }

    function getVaultConfig() public returns (VaultConfig memory) {
        vm.startBroadcast();
        Vault vault = Vault(0x6989Aed697817883B137114ba50A900d45ff5A59);
        vm.stopBroadcast();
        return VaultConfig({account: BURNER_WALLET, vault: vault});
    }

    function getKingConfig() public returns (KingConfig memory) {
        King king = King(payable(0xc5A6bfB97bC242C4ba7358a0b0B4711Ba6F62501));
        vm.startBroadcast();
        Pawn pawn = new Pawn(0xc5A6bfB97bC242C4ba7358a0b0B4711Ba6F62501);
        vm.stopBroadcast();
        return KingConfig({account: BURNER_WALLET, king: king, pawn: pawn});
    }

    function getReentranceConfig() public returns (ReentranceConfig memory) {
        Reentrance reentrance = Reentrance(payable(0x390E7953A9D552581A3354455E517366e40c3F3D));
        vm.startBroadcast();
        ReentranceHack reentranceHack = new ReentranceHack(payable(0x390E7953A9D552581A3354455E517366e40c3F3D));
        vm.stopBroadcast();
        return ReentranceConfig({account: BURNER_WALLET, reentrance: reentrance, reentranceHack: reentranceHack});
    }

    function getElevatorConfig() public returns (ElevatorConfig memory) {
        Elevator elevator = Elevator(0xbd56283454bE724e34450900a420Db49Ec862C7e);
        vm.startBroadcast();
        ElevatorHack elevatorHack = new ElevatorHack(address(elevator));
        vm.stopBroadcast();
        return ElevatorConfig({account: BURNER_WALLET, elevator: elevator, elevatorHack: elevatorHack});
    }

    function getGatekeeperOneConfig() public returns (GatekeeperOneConfig memory) {
        GatekeeperOne gatekeeperOne = GatekeeperOne(payable(0x005409bFE59Dd87F260e6E7688672F20ec9D351F));
        vm.startBroadcast();
        GatekeeperOneHack gatekeeperOneHack = new GatekeeperOneHack(payable(0x005409bFE59Dd87F260e6E7688672F20ec9D351F));
        vm.stopBroadcast();
        return GatekeeperOneConfig({
            account: BURNER_WALLET,
            gatekeeperOne: gatekeeperOne,
            gatekeeperOneHack: gatekeeperOneHack
        });
    }

    function getGatekeeperTwoConfig() public returns (GatekeeperTwoConfig memory) {
        GatekeeperTwo gatekeeperTwo = GatekeeperTwo(0x64A9c9B8C1720610c68cb072f8F9FeE9E02B9f99);
        vm.startBroadcast();
        GatekeeperTwoHack gatekeeperTwoHack = new GatekeeperTwoHack(0x64A9c9B8C1720610c68cb072f8F9FeE9E02B9f99);
        vm.stopBroadcast();
        return GatekeeperTwoConfig({
            account: BURNER_WALLET,
            gatekeeperTwo: gatekeeperTwo,
            gatekeeperTwoHack: gatekeeperTwoHack
        });
    }

    function getDenialConfig() public returns (DenialConfig memory) {
        Denial denial = Denial(payable(0xfF72793304416cBE15EBa991C1504Ea0F3662C90));
        vm.startBroadcast();
        DenialHack denialHack = new DenialHack(denial);
        vm.stopBroadcast();
        return DenialConfig({account: BURNER_WALLET, denial: denial, denialHack: denialHack});
    }

    function getShopConfig() public returns (ShopConfig memory) {
        Shop shop = Shop(0xfc467b8d63Cb43155092C9c7AE643F9f12A2F957);
        vm.startBroadcast();
        ShopHack shopHack = new ShopHack(shop);
        vm.stopBroadcast();
        return ShopConfig({account: BURNER_WALLET, shop: shop, shopHack: shopHack});
    }

    function getDexConfig() public returns (DexConfig memory) {
        Dex dex = Dex(0xb00FD583cbe6837Cb6e1000eda3b3765231f57a4);
        return DexConfig({account: BURNER_WALLET, dex: dex});
    }

    function getDexTwoConfig() public returns (DexTwoConfig memory) {
        DexTwo dexTwo = DexTwo(0x12bD48B924b735aBe93eAd8FDEE106BDd4984C5D);
        return DexTwoConfig({account: BURNER_WALLET, dexTwo: dexTwo});
    }

    function getPuzzleWalletConfig() public returns (PuzzleWalletConfig memory) {
        PuzzleWallet puzzleWallet = PuzzleWallet(0xF98b1b14fC6D92d54c70FCc34fB4359f91f76c45);
        return PuzzleWalletConfig({account: BURNER_WALLET, puzzleWallet: puzzleWallet});
    }

    function getBasicSepoliaConfig() public pure returns (BasicConfig memory) {
        return BasicConfig({account: BURNER_WALLET});
    }

    function getOrCreateAnvilEthConfig() public view returns (BasicConfig memory) {
        if (basicConfig.account != address(0)) {
            return basicConfig;
        }

        return BasicConfig({account: ANVIL_DEFAULT_ACCOUNT});
    }
}
