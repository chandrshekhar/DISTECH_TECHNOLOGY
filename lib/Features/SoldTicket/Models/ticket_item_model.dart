class TicketItemModel {
  final String? slNo;
  final String? ticketNo;
  final String? sem;

  TicketItemModel({this.slNo, this.ticketNo, this.sem});
}

List<TicketItemModel> ticketItemList = [
  TicketItemModel(slNo: '01', ticketNo: 'AA 485758', sem: '05'),
  TicketItemModel(slNo: '02', ticketNo: 'PL 482548', sem: '10'),
  TicketItemModel(slNo: '03', ticketNo: 'SO 254856', sem: '20'),
  TicketItemModel(slNo: '04', ticketNo: 'ZD 365895', sem: '50'),
  TicketItemModel(slNo: '05', ticketNo: 'AA 485758', sem: '100'),
  TicketItemModel(slNo: '06', ticketNo: 'SJ 485758', sem: '200'),
  TicketItemModel(slNo: '07', ticketNo: 'AA 485758', sem: '500'),
  TicketItemModel(slNo: '08', ticketNo: 'PL 482548', sem: '200'),
  TicketItemModel(slNo: '09', ticketNo: 'SO 254856', sem: '100'),
  TicketItemModel(slNo: '10', ticketNo: 'ZD 365895', sem: '100'),
  TicketItemModel(slNo: '11', ticketNo: 'AA 485758', sem: '20'),
  TicketItemModel(slNo: '12', ticketNo: 'SJ 485758', sem: '10'),
];
