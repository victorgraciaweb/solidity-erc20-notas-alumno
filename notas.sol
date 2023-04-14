// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract notas is ERC20, Ownable {

    // Direccion del profesor
    address public ownerSmartContract;

    // Constructor
    constructor() ERC20("Notas", "NOT"){
        ownerSmartContract = msg.sender;
        _mint(address(this), 1000);
    }

    // Mapping para relacionar el hash de la identidad del alumno con su nota del examen
    mapping (bytes32 => uint) notas;

    // Eventos
    event alumno_evaluado(bytes32);
    event tokens_otorgados(bytes32);

    // Funcion para evaluar a alumnos
    function Evaluar(address alumno, uint _nota) public onlyOwner {
        bytes32 hashAlumno = keccak256(abi.encodePacked(alumno));

        require(notas[hashAlumno] == 0, "El alumno ha sido evaluado  previamente");

        notas[hashAlumno] = _nota;

        if(_nota >= 5){
            asignarTokeks(alumno);
        }

        emit alumno_evaluado(hashAlumno);
    }

    // Funcion privada para dar tokens si aprueba alumno
    function asignarTokeks(address alumno) internal {
        bytes32 hashAlumno = keccak256(abi.encodePacked(alumno));

        _transfer(address(this), alumno, 100);

        emit tokens_otorgados(hashAlumno);
    }

    // Funcion para ver las notas de un alumno
    function VerNotaAlumno(address alumno) public view returns(uint) {
        bytes32 hashAlumno = keccak256(abi.encodePacked(alumno));
        require(msg.sender == ownerSmartContract || msg.sender == alumno, "No tienes los permisos necesarios");

        require(notas[hashAlumno] != 0, "El alumno aun no ha sido evaluado");

        uint notaAlumno = notas[hashAlumno];
        return notaAlumno;
    }

    // Visualizacion del balance de tokens ERC-20 del Smart Contract
    function balanceTokensSC() public view returns (uint256){
        return balanceOf(address(this));
    }

}