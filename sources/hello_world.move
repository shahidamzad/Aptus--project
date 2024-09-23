// module Voting::SimpleVoting {

//     use aptos_framework::coin;
//     use aptos_framework::account;
//     use std::vector;
//     use std::signer;

//     struct Proposal has key {
//         name: vector<u8>,
//         votes: u64,
//     }

//     struct Voter has store {
//         has_voted: bool,
//     }

//     struct VotingSystem has key {
//         proposals: vector<Proposal>,
//         voters: vector<address>,
//     }

//     // Initialize the voting system with a list of proposals
//     public fun create_voting_system(
//         account: &signer,
//         proposal_names: vector<vector<u8>>,
//     ) {
//         let proposals = vector::empty<Proposal>();
//         let i = 0;
//         let num_proposals = vector::length(&proposal_names);

//         while (i < num_proposals) {
//             let proposal_name = vector::borrow(&proposal_names, i);
//             vector::push_back(
//                 &mut proposals,
//                 Proposal {
//                     name: proposal_name.to_vec(),
//                     votes: 0,
//                 },
//             );
//             i = i + 1;
//         };

//         move_to(account, VotingSystem { proposals, voters: vector::empty<address>() });
//     }

//     // Allow a user to vote for a specific proposal by its index
//     public fun vote(account: &signer, proposal_index: u64) {
//         let voting_system = borrow_global_mut<VotingSystem>(signer::address_of(account));

//         // Check if the user has already voted
//         let voter_address = signer::address_of(account);
//         if (vector::contains(&voting_system.voters, &voter_address)) {
//             abort 1; // Already voted
//         }
//     }
// }
       module Attendance::AttendanceList {

    use aptos_framework::signer;
    use std::vector;

    struct Attendances has key {
        attendees: vector<address>,
    }

    // Initialize the attendance list
    public fun create_attendance_list(account: &signer)  {
        move_to(account, Attendances { attendees: vector::empty<address>() });
    }

    // Mark attendance for the caller
    public fun mark_attendance(account: &signer) acquires Attendances {
        let attendance = borrow_global_mut<Attendances>(signer::address_of(account));
        let user_address = signer::address_of(account);

        // Check if the user has already marked attendance
        if (!vector::contains(&attendance.attendees, &user_address)) {
            vector::push_back(&mut attendance.attendees, user_address);
        }
    }

    // Retrieve the list of attendees
    public fun get_attendees(account: &signer): vector<address> acquires Attendances {
        let attendance = borrow_global<Attendances>(signer::address_of(account));
        attendance.attendees
    }
}

