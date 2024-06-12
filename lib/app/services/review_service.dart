import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor_model.dart';
import '../models/review_dart.dart';

class ReviewService {
  Future<List<ReviewModel>> getListReview(Doctor doctor,
      {int limit = 5}) async {
    // QueryBuilder<ReviewModel> query = QueryBuilder<ReviewModel>(ReviewModel());
    // //   ..whereEqualTo('doctor', doctor.toPointer());
    // if (limit != null) query.setLimit(limit);
    // ParseResponse apiResponse = await query.query();
    // if (apiResponse.success) {
    //   if (apiResponse.results == null) return [];
    //   var list = apiResponse.results!.cast<ReviewModel>();
    //   return list;
    // } else {
    //   return Future.error(apiResponse.error!.message);
    // }
    print(doctor.doctorId);
    var doctorReviewRef = await FirebaseFirestore.instance
        .collection('Review')
        .where('doctorId', isEqualTo: doctor.doctorId)
        .limit(limit)
        .get();
    print('review length : ${doctorReviewRef.docs.length}');
    if (doctorReviewRef.docs.isEmpty) {
      return [];
    }
    List<ReviewModel> listReview = doctorReviewRef.docs
        .map((review) => ReviewModel.fromFirestore(review))
        .toList();

    return listReview;
  }
}
