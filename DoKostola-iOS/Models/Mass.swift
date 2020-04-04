import Foundation

struct Mass {
    let date: Date
    let time: Date
    let note: String?

    init(
        massDTO: MassDTO,
        dateFormatter: DateFormatter = .yearMonthDay,
        timeFormatter: DateFormatter = .hourMinutesSeconds
    ) throws {
        guard
            let date = dateFormatter.date(from: massDTO.date),
            let time = timeFormatter.date(from: massDTO.time) else {
            throw DoKostolaError.invaliDateFormat
        }

        self.date = date
        self.time = time
        self.note = massDTO.note
    }
}

extension Mass: Hashable {

}
