#pragma once

#include <iostream>
#include <iomanip>

#include <sys/time.h>

/**
 * @brief Timer
 */

namespace mpac_generic
{
    class Timer
{
    public:
        /**
         * @brief Constructor. Starts the timer.
         */
        Timer()
        {
            // timediff = 0.0;
            start();
        }

        /**
         * @brief Re/starts the timer.
         */
        void start()
        {
            timediff = 0.0;
            gettimeofday(&start_time, 0);
        }

        /**
         * @brief Stops the timer.
         */
        void stop()
        {
            gettimeofday(&end_time, 0);
            timediff = (double) end_time.tv_sec - start_time.tv_sec 
                     + 0.000001 * (end_time.tv_usec - start_time.tv_usec);
        }

        /**
         * @brief Returns the measured time interval (second).
         *
         * @return time interval (second).
         */
        double get()
        {
            return timediff;
        }

        /**
         * @brief Outputs the measured time interval.
         *
         * @param[in,out] out output stream.
         * @param[in] timer the timer.
         *
         * @return output stream.
         */
        // friend ostream& operator<< (ostream& out, const swTimer& timer)
        // {
        //     out << setiosflags(ios::fixed) << setprecision(6)
        //         << "Timer value = "        << timer.timediff;
        //     return(out);
        // }


    private:
        struct timeval start_time;
        struct timeval end_time;
        double timediff;
};




/**
 * @brief Get and output the system time.
 */
class GetTime
{
    public:
        GetTime()
        {
            gettimeofday(&start_time, 0);
        }

        // friend ostream& operator<< (ostream& out, const swGetTime& swtime)
        // {
        //     out << setiosflags(ios::fixed) << setprecision(6)
        //         << "System time = "        << (double) swtime.start_time.tv_sec 
        //                                       + 0.000001 * swtime.start_time.tv_usec;
        //     return(out);
        // }


    private:
        struct timeval start_time;
};

}
