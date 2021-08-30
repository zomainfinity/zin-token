// SPDX-License-Identifier: ISC

pragma solidity >=0.6.0 <=0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title DemoToken ERC20 token
 * @dev This is the base token to allow for staking and trading
 */
contract ZomaInfinity is ERC20, AccessControl {
    using SafeMath for uint256;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() ERC20("ZomaInfinity", "ZIN") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(MINTER_ROLE, _msgSender());

        //Init totalSupply
        _mint(_msgSender(), uint256(1000000000).mul(uint256(10)**18));
    }

    /**
     * @dev Returns true if the given address has MINTER_ROLE.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function isMinter(address _address) public view returns (bool) {
        return hasRole(MINTER_ROLE, _address);
    }

    function addMinter(address _address) public {
        require(
            hasRole(0x00, _msgSender()),
            "DemoToken: must have DEFAULT_ADMIN_ROLE"
        );
        grantRole(MINTER_ROLE, _address);
    }

    /**
     * @dev Creates `amount` new tokens for `to`.
     *
     * See {ERC20-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(address to, uint256 amount) public virtual returns (bool) {
        require(
            hasRole(MINTER_ROLE, _msgSender()),
            "DemoToken: must have minter role to mint"
        );

        _mint(to, amount);
        return true;
    }
}
