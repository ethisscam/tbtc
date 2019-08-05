pragma solidity ^0.5.10;

import {IKeep} from "./IKeep.sol";

contract KeepBridge is IKeep {
    address keepRegistry;

    function wasDigestApprovedForSigning(address _keepAddress, bytes32 _digest) external view returns (uint256){
        //TODO: Implement
        return 0;
    }


    function approveDigest(address _keepAddress, bytes32 _digest) external returns (bool _success){
        //TODO: Implement
        return _success;
    }

    function submitSignatureFraud(
        address _keepAddress,
        uint8 _v,
        bytes32 _r,
        bytes32 _s,
        bytes32 _signedDigest,
        bytes calldata _preimage
    ) external returns (bool _isFraud){
        //TODO: Implement
        return _isFraud;
    }

    function distributeEthToKeepGroup(address _keepAddress) external payable returns (bool){
        //TODO: Implement
        return false;
    }

    function distributeERC20ToKeepGroup(address _keepAddress, address _asset, uint256 _value) external returns (bool){
        //TODO: Implement
        return false;
    }

    function requestNewKeep(uint256 _m, uint256 _n) external payable returns (address _keepAddress){
        address keepVendorAddress = KeepRegistry(keepRegistry)
            .getVendor("ECDSAKeep");

        _keepAddress = ECDSAKeepVendor(keepVendorAddress)
            .openKeep(_n,_m, msg.sender);
    }

    // get the result of a keep formation
    // should return a 64 byte packed pubkey (x and y)
    // error if not ready yet
    function getKeepPubkey(address _keepAddress) external view returns (bytes memory){
        return ECDSAKeep(_keepAddress).getPublicKey();
    }


    // returns the amount of the keep's ETH bond in wei
    function checkBondAmount(address _keepAddress) external view returns (uint256){
        //TODO: Implement
        return 0;
    }

    function seizeSignerBonds(address _keepAddress) external returns (bool){
        //TODO: Implement
        return false;
    }

    //TODO: add: onlyOwner
    function initialize(address _keepRegistry) public {
        keepRegistry = _keepRegistry;
    }
}

/// @notice Interface for communication with `KeepRegistry` contract
/// @dev It allows to call a function without the need of low-level call
interface KeepRegistry {
    /// @notice Get a keep vendor contract address for a keep type.
    /// @param _keepType Keep type.
    /// @return Keep vendor contract address.
    function getVendor(string calldata _keepType) external view returns (address);
}

/// @notice Interface for communication with `ECDSAKeepVendor` contract
/// @dev It allows to call a function without the need of low-level call
interface ECDSAKeepVendor {
    /// @notice Open a new ECDSA keep.
    /// @param _groupSize Number of members in the keep.
    /// @param _honestThreshold Minimum number of honest keep members.
    /// @param _owner Address of the keep owner.
    /// @return Opened keep address.
    function openKeep(
        uint256 _groupSize,
        uint256 _honestThreshold,
        address _owner
    ) external payable returns (address keepAddress);
}

/// @notice Interface for communication with `ECDSAKeep` contract
/// @dev It allows to call a function without the need of low-level call
interface ECDSAKeep {
    /// @notice Returns the keep signer's public key.
    /// @return Signer's public key.
    function getPublicKey() external view returns (bytes memory);
}