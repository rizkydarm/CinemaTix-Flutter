
part of '_page.dart';

class CheckoutPage extends StatelessWidget {
  
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<CheckoutCubit>();

    final movie = cubit.selectedMovie!;
    final seats = cubit.selectedSeatsEntity!;
    final cinema = cubit.selectedCinemaMall!;
    final datetime = cubit.selectedDateTimeBookingEntity!;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Builder(
        builder: (scafContext) {
          return ListView(
            children: [
              ColoredBox(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 160,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: FastCachedImage(
                            url: TMDBApi.getImageUrl(movie.posterPath),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Movie',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(movie.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(movie.genres.join(', ')),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ColoredBox(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Date & Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(datetime.date),
                        Text(datetime.time),
                      ],
                    ),
                  ),
                ),
              ),
              ColoredBox(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(cinema.cinemaMall.cinema),
                      Text(cinema.cinemaMall.mall),
                      Text(cinema.city.name),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ColoredBox(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tickets',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Total: ${seats.total}'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            
                          },
                          child:const Text('See Detail'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                tileColor: Theme.of(context).cardColor,
                title: const Text('Payment Method',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                subtitle: const Text('QRIS'),
                trailing: TextButton(
                  onPressed: () {
                    final paymentVA = [
                      {
                        'nama': 'BCA VA',
                        'logo': 'bca_logo.png'
                      },
                      {
                        'nama': 'Mandiri VA',
                        'logo': 'mandiri_logo.png'
                      },
                      {
                        'nama': 'BRI VA',
                        'logo': 'bri_logo.png'
                      },
                      {
                        'nama': 'BNI VA',
                        'logo': 'bni_logo.png'
                      }
                    ];
                    final paymentWallet = [
                      {
                        'nama': 'Dana',
                        'logo': 'dana_logo.png'
                      },
                      {
                        'nama': 'Gopay',
                        'logo': 'gopay_logo.png'
                      },
                      {
                        'nama': 'OVO',
                        'logo': 'ovo_logo.png'
                      },
                      {
                        'nama': 'LinkAja',
                        'logo': 'linkaja_logo.png'
                      }
                    ];
                    showModalBottomSheet(
                      context: scafContext,
                      isScrollControlled: true,
                      builder: (context) => DraggableScrollableSheet(
                        builder: (context, controller) => ListView(
                          controller: controller,
                          children: [
                            ... List.generate(paymentVA.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: MaterialButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.grey
                                    ),
                                    borderRadius: BorderRadius.circular(16)
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Image.asset('assets/payment_logo/${paymentVA[index]['logo']}',
                                        width: 100,
                                        height: 60,
                                        fit: BoxFit.contain,
                                      ),
                                      Text(paymentVA[index]['nama'] as String),
                                    ],
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      showDragHandle: true,
                      enableDrag: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                      ),
                    );
                  },
                  child:const Text('Change'),
                ),
              ),
              const SizedBox(height: 16,),
              ColoredBox(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Total Payment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('IDR 50.000 x ${seats.total}'),
                      Text('IDR ${(50000*seats.total)}'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                  // Handle purchase logic here
                  },
                  child: Text('Purchase'),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

// [http-response] [GET] https://api.themoviedb.org/3/movie/939243
// Status: 200
// Message: OK
// Data: {
//   "adult": false,
//   "backdrop_path": "/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg",
//   "belongs_to_collection": {
//     "id": 720879,
//     "name": "Sonic the Hedgehog Collection",
//     "poster_path": "/fwFWhYXj8wY6gFACtecJbg229FI.jpg",
//     "backdrop_path": "/l5CIAdxVhhaUD3DaS4lP4AR2so9.jpg"
//   },
//   "budget": 122000000,
//   "genres": [
//     {
//       "id": 28,
//       "name": "Action"
//     },
//     {
//       "id": 878,
//       "name": "Science Fiction"
//     },
//     {
//       "id": 35,
//       "name": "Comedy"
//     },
//     {
//       "id": 10751,
//       "name": "Family"
//     }
//   ],
//   "homepage": "https://www.sonicthehedgehogmovie.com",
//   "id": 939243,
//   "imdb_id": "tt18259086",
//   "origin_country": [
//     "US"
//   ],
//   "original_language": "en",
//   "original_title": "Sonic the Hedgehog 3",
//   "overview": "Sonic, Knuckles, and Tails reunite against a powerful new adversary, Shadow, a mysterious villain with powers unlike anything they have faced before. With their abilities outmatched in every way, Team Sonic must seek out an unlikely alliance in hopes of stopping Shadow and protecting the planet.",
//   "popularity": 3403.343,
//   "poster_path": "/mubt4bnVfpJ5lBMq93DidEuMkJr.jpg",
//   "production_companies": [
//     {
//       "id": 4,
//       "logo_path": "/gz66EfNoYPqHTYI4q9UEN4CbHRc.png",
//       "name": "Paramount Pictures",
//       "origin_country": "US"
//     },
//     {
//       "id": 333,
//       "logo_path": "/5xUJfzPZ8jWJUDzYtIeuPO4qPIa.png",
//       "name": "Original Film",
//       "origin_country": "US"
//     },
//     {
//       "id": 77884,
//       "logo_path": "/dP2lxVNctD5Cried0IWVqgrO2o9.png",
//       "name": "Marza Animation Planet",
//       "origin_country": "JP"
//     },
//     {
//       "id": 113750,
//       "logo_path": "/A3QVZ9Ah0yI2d2GiXUFpdlbTgyr.png",
//       "name": "SEGA",
//       "origin_country": "JP"
//     },
//     {
//       "id": 10644,
//       "logo_path": "/ocLZIdYJBppuCt1rhYEb2jbpt5F.png",
//       "name": "Blur Studio",
//       "origin_country": "US"
//     },
//     {
//       "id": 168701,
//       "logo_path": "/vWdZFT4V64CCv12D10m44duQjyg.png",
//       "name": "SEGA of America",
//       "origin_country": "US"
//     }
//   ],
//   "production_countries": [
//     {
//       "iso_3166_1": "JP",
//       "name": "Japan"
//     },
//     {
//       "iso_3166_1": "US",
//       "name": "United States of America"
//     }
//   ],
//   "release_date": "2024-12-19",
//   "revenue": 211552146,
//   "runtime": 110,
//   "spoken_languages": [
//     {
//       "english_name": "Spanish",
//       "iso_639_1": "es",
//       "name": "Español"
//     },
//     {
//       "english_name": "English",
//       "iso_639_1": "en",
//       "name": "English"
//     },
//     {
//       "english_name": "Japanese",
//       "iso_639_1": "ja",
//       "name": "日本語"
//     },
//     {
//       "english_name": "French",
//       "iso_639_1": "fr",
//       "name": "Français"
//     }
//   ],
//   "status": "Released",
//   "tagline": "New adventure. New rival.",
//   "title": "Sonic the Hedgehog 3",
//   "video": false,
//   "vote_average": 7.641,
//   "vote_count": 276
// }