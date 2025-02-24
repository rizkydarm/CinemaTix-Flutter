
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

    num tax = 50000*seats.total*0.1;
    num totalPayment = (50000*seats.total) + tax + 3000;

    String? paymentMethod;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(),
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
                            url: TMDBApi.getImageUrl(movie.posterPath!),
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
                              Text(movie.title ?? '-',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(movie.genres?.join(', ') ?? '-'),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                padding: const EdgeInsets.symmetric(vertical: 8),
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
              StatefulValueBuilder<String?>(
                initialValue: null,
                builder: (context, value, setValue) {
                  return ListTile(
                    tileColor: Theme.of(context).cardColor,
                    title: const Text('Payment Method',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    subtitle: Text(value ?? ''),
                    trailing: TextButton(
                      onPressed: () async {
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
                        paymentMethod = await showModalBottomSheet<String>(
                          context: scafContext,
                          isScrollControlled: true,
                          enableDrag: true,
                          showDragHandle: true,
                          builder: (context) => DraggableScrollableSheet(
                            expand: false,
                            maxChildSize: 0.8,
                            initialChildSize: 0.6,
                            builder: (context, controller) => ListView(
                              padding: const EdgeInsets.all(16),
                              controller: controller,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Colors.grey
                                      ),
                                      borderRadius: BorderRadius.circular(16)
                                    ),
                                    onPressed: () {
                                      setValue('QRIS');
                                      scafContext.pop('QRIS');
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset('assets/payment_logo/qris_logo.jpeg',
                                          width: 80,
                                          height: 40,
                                          fit: BoxFit.contain,
                                        ),
                                        const Text('QRIS'),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text('Wallet',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                                ... List.generate(paymentWallet.length, (index) {
                                  return PaymentButton(
                                    payments: paymentWallet, 
                                    index: index,
                                    onPressed: (index) {
                                      setValue(paymentWallet[index]['nama'] as String);
                                      scafContext.pop(paymentWallet[index]['nama'] as String);
                                    },
                                  );
                                }),
                                const Text('Bank VA',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                                ... List.generate(paymentVA.length, (index) {
                                  return PaymentButton(
                                    payments: paymentVA, 
                                    index: index,
                                    onPressed: (p0) {
                                      setValue(paymentWallet[index]['nama'] as String);
                                      scafContext.pop();
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                          ),
                        );
                      },
                      child:const Text('Change'),
                    ),
                  );
                }
              ),
              const SizedBox(height: 8,),
              ColoredBox(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Detail Payment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Tickets (${seats.total})',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(intToIdr(50000*seats.total)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tax (10%)',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(intToIdr(tax)),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('App Fee',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('IDR3.000'),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                            ),
                          ),
                          Text(intToIdr(totalPayment)),
                        ],
                      ),                
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<CheckoutCubit, BlocState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: (state is LoadingState) ? null : () async {
                        if (paymentMethod != 'QRIS') {
                          return;
                        }
                        final user = context.read<AuthCubit>().user;
                        context.read<CheckoutCubit>().saveTransaction(user!, intToIdr(totalPayment), paymentMethod!, {
                          'tax': intToIdr(tax),
                          'admin': 'IDR3.000',
                        }).then((transaction) {
                          if (context.mounted) {
                            context.go('/waiting_trans', extra: transaction);
                          }
                        });
                      },
                      child: const Text('Purchase'),
                    );
                  }
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  
  const PaymentButton({
    super.key,
    required this.payments,
    required this.index,
    required this.onPressed,
  });

  final List<Map<String, String>> payments;
  final int index;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(16)
        ),
        onPressed: () => onPressed(index),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/payment_logo/${payments[index]['logo']}',
              width: 80,
              height: 40,
              fit: BoxFit.contain,
            ),
            Text(payments[index]['nama'] as String),
          ],
        ),
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