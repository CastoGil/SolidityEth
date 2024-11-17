// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Auction {
    //variables de estado
    address public auctioneer; //Direccion del creador del contrato
    uint256 public auctionStart; // Marca de tiempo de inicio
    uint256 public auctionDuration; //Duracion inicial de la subasta
    uint256 public extensionTime = 10 minutes; //Tiempo de extension por cada oferta
    uint256 public highestBid; //Valor de la oferta mas alta
    address public highestBidder; //Direccion del mejor ofertante
    bool public ended; //Estado de la subasta
    //Estructura Oferta
    struct Bid {
        uint256 amount; //Monto ofertado
        uint256 deposit; //Deposito Acumulado
    }
    mapping(address => Bid) public bids; //Registro de las ofertas
    address[] public bidders; //Lista de participantes

    //Eventos
    event NewBid(address indexed biddder, uint256 amount); //Nueva oferta
    event AuctionEndend(address winner, uint256 amount); //Subasta Finalizada

    //Constructor para inicializar la subasta
    constructor(uint256 _auctionDuration) {
        auctioneer = msg.sender;
        auctionStart = block.timestamp;
        auctionDuration = _auctionDuration;
    }

    //Funcion para ofertar en la subasta
    function placeBid() external payable {
        //Verifica que la subasta este activa y que la oferta cumpla con el minimo requerido
        require(
            block.timestamp < auctionStart + auctionDuration,
            "Auction has ended"
        );
        require(
            msg.value > (highestBid * 105) / 100,
            "Bid must be at least 5% higher than the current highest bid"
        );

        //Actualiza la oferta mas alta
        if (bids[msg.sender].amount == 0) {
            bidders.push(msg.sender);
        }
        bids[msg.sender].amount += msg.value;
        highestBid = msg.value;
        highestBidder = msg.sender;

        //Extiende la duracion de la subasta si esta dentro de los ultimos 10 minutos
        if (auctionStart + auctionDuration - block.timestamp <= 10 minutes) {
            auctionDuration += extensionTime;
        }
        emit NewBid(msg.sender, msg.value);
    }

    //Funcion para mostrar el ganador de la subasta
    function showWinner() public view returns (address, uint256) {
        require(ended, "Auction has not ended");
        return (highestBidder, highestBid);
    }

    //Funcion para mostrar todas las ofertas
    function showBids()
        public
        view
        returns (address[] memory, uint256[] memory)
    {
        uint256[] memory amounts = new uint256[](bidders.length);
        for (uint256 i = 0; i < bidders.length; i++) {
            amounts[i] = bids[bidders[i]].amount;
        }
        return (bidders, amounts);
    }

    //Funcion para devolver los depositos a los participantes que no ganaron
    function refundDeposits() external {
        require(
            block.timestamp > auctionStart + auctionDuration,
            "Auction is still active"
        );
        require(
            msg.sender != highestBidder,
            "Winner cannot withdraw their deposit"
        );
        uint256 deposit = bids[msg.sender].deposit;
        uint256 refund = (deposit * 98) / 100; //Descuento del 2% por gas
        bids[msg.sender].deposit = 0;
        payable(msg.sender).transfer(refund);
    }

    //Funcion para retirar el exceso de deposito durante la subasta
    function withdrawExcess() external {
        require(!ended, "Auction has ended");
        uint256 excess = bids[msg.sender].deposit - bids[msg.sender].amount;
        require(excess > 0, "No excess to withdraw");
        bids[msg.sender].deposit -= excess;
        payable(msg.sender).transfer(excess);
    }

    //Funcion para finalizar la subasta
    function endAuction() external {
        require(
            msg.sender == auctioneer,
            "Only the auctioneer can end auction"
        );
        require(
            block.timestamp > (auctionStart + auctionDuration),
            "Auction has not ended yet"
        );
        ended = true;
        emit AuctionEndend(highestBidder, highestBid);
    }
}
