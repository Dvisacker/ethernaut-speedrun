-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil zktest

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(DEV_ETH_PK) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeployMinimalStablecoin.s.sol:DeployMinimalStablecoin $(NETWORK_ARGS)

hack-force-sepolia :; forge script script/HackForce.s.sol:HackForce $(NETWORK_ARGS)

hack-vault :; forge script script/HackVault.s.sol:HackVaultScript $(NETWORK_ARGS)

hack-king :; forge script script/HackKing.s.sol:HackKingScript $(NETWORK_ARGS)

hack-reentrancy :; forge script script/HackReentrancy.s.sol:HackReentrancyScript $(NETWORK_ARGS)

hack-elevator :; forge script script/HackElevator.s.sol:HackElevator $(NETWORK_ARGS)

hack-gatekeeper-one :; forge script script/HackGatekeeper.s.sol:HackGatekeeperScript $(NETWORK_ARGS)

hack-gatekeeper-two :; forge script script/HackGatekeeper2.s.sol:HackGatekeeper2Script $(NETWORK_ARGS)

hack-naught-coin :; forge script script/HackNaughtCoin.s.sol:HackNaughtCoinScript $(NETWORK_ARGS)

hack-preservation :; forge script script/HackPreservation.s.sol:HackPreservationScript $(NETWORK_ARGS)

hack-recovery :; forge script script/HackRecovery.s.sol:HackRecoveryScript $(NETWORK_ARGS)

hack-solver :; forge script script/HackSolver.s.sol:HackSolverScript $(NETWORK_ARGS)

hack-denial :; forge script script/HackDenial.s.sol:HackDenialScript $(NETWORK_ARGS)

hack-shop :; forge script script/HackShop.s.sol:HackShopScript $(NETWORK_ARGS)

hack-dex :; forge script script/HackDex.s.sol:HackDexScript $(NETWORK_ARGS)

hack-dex-two :; forge script script/HackDexTwo.s.sol:HackDexTwoScript $(NETWORK_ARGS)

hack-puzzle-wallet :; forge script script/HackPuzzleWallet.s.sol:HackPuzzleWalletScript $(NETWORK_ARGS)

test-solver :; forge script script/HackSolver.s.sol:TestSolverScript $(NETWORK_ARGS)